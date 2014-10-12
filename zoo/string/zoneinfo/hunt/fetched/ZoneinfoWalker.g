/*
 * Copyright 2010 Class Action P/L
 *
  * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 
tree grammar ZoneinfoWalker;

options {
	tokenVocab=Zoneinfo;
	ASTLabelType=CommonTree;
}
	
@header {
	package com.classactionpl.tz;
	
	import java.util.ArrayList;
	import java.util.Calendar;
	import java.util.HashMap;
	import java.util.List;
	import java.util.Map;
	
	import com.classactionpl.tz.Rule.OnType;
	import com.classactionpl.tz.Rule.TimeOfDayType;
	import com.classactionpl.tz.Rule.YearType;
	import com.classactionpl.tz.Rule.YearValueType;
}

@members {
	private Map<String, AbstractZone> zones;
	
	public void setZones(Map<String, AbstractZone> zones) {
		this.zones = zones;
	}

	private Map<String, List<Rule>> ruleLists = new HashMap<String, List<Rule>>();
	
	enum ZoneRuleType {
		noRuleOrSave,
		rule,
		save
	}
}

line
	: ruleLine* zoneLine* linkLine*
	;

ruleLine
	: 'Rule' ruleName ruleFrom ruleTo ruleType ruleIn ruleOn ruleAt ruleSave ruleLetters {
		String ruleName = $ruleName.text;
		List<Rule> rules = ruleLists.get(ruleName);
		if (rules == null) {
			rules = new ArrayList<Rule>();
			ruleLists.put(ruleName, rules);
		}
		
		Rule rule = new Rule();
		rules.add(rule);
		
		rule.setName(ruleName);
		
		rule.setFrom($ruleFrom.from);
		rule.setFromType($ruleFrom.fromType);
		
		rule.setTo($ruleTo.to);
		rule.setToType($ruleTo.toType);
		rule.setToTypeOnly($ruleTo.toTypeOnly);
		
		rule.setType($ruleType.type);
		
		rule.setIn($ruleIn.in);
		
		rule.setOn($ruleOn.on);
		rule.setOnType($ruleOn.onType);
		rule.setOnTypeValue($ruleOn.onTypeValue);
		
		rule.setAt($ruleAt.at);
		rule.setAtType($ruleAt.atType);
		
		rule.setSave($ruleSave.save);
		
		rule.setLetters($ruleLetters.letters);
	}
	;

zoneLine
scope {
	ZoneRuleType zoneRuleType;
}	: 'Zone' zoneName zoneGmtOffset zoneRules zoneFormat zoneUntil? {
		String zoneName = $zoneName.text;
		Zone zone = (Zone) zones.get(zoneName);
		if (zone == null) {
			zone = new Zone();
			zone.setName(zoneName);
			zones.put(zoneName, zone);
		}
		
		ZoneDetail zoneDetail = new ZoneDetail();
		zone.getDetails().add(zoneDetail);
		
		zoneDetail.setUtcOffset($zoneGmtOffset.seconds);
		
		switch ($zoneLine::zoneRuleType) {
		case noRuleOrSave:
			zoneDetail.setSave(0);
			break;
		case rule:
			List<Rule> rules = ruleLists.get($zoneRules.text);
			zoneDetail.setRules(rules);
			break;
		default:
			zoneDetail.setSave(Integer.valueOf($zoneRules.text));
		}
		
		zoneDetail.setFormat($zoneFormat.format);
		zoneDetail.setDstFormat($zoneFormat.dstFormat);
		
		if ($zoneUntil.text != null) {
			zoneDetail.setUntil($zoneUntil.year);
			zoneDetail.setUntilIn($zoneUntil.in);
			zoneDetail.setUntilOn($zoneUntil.on);
			zoneDetail.setUntilOnType($zoneUntil.onType);
			zoneDetail.setUntilOnTypeValue($zoneUntil.onTypeValue);
			zoneDetail.setUntilAt($zoneUntil.at);
			zoneDetail.setUntilAtType($zoneUntil.atType);
		}
	};

linkLine
	: 'Link' linkFrom linkTo {
		String linkFromZoneName = $linkFrom.text;
		Zone targetZone = (Zone) zones.get(linkFromZoneName);
		if (targetZone != null) {
			Link zone = new Link();
			String zoneName = $linkTo.text;
			zone.setName(zoneName);
			zone.setTargetZone(targetZone);
			zones.put(zoneName, zone);
		}
	}
	;

ruleName
	: ID
	;
	
ruleFrom returns [int from, YearValueType fromType]
	: INT {
		$from = Integer.valueOf($INT.text);
		$fromType = YearValueType.value;
	}
	| YEAR_MINMAX {
		if ($YEAR_MINMAX.text.equals("min")) {
			$fromType = YearValueType.min;
		} else {
			$fromType = YearValueType.max;
		}
	}
	;
	
ruleTo returns [int to, YearValueType toType, boolean toTypeOnly]
	: INT {
		$to = Integer.valueOf($INT.text);
		$toType = YearValueType.value;
		$toTypeOnly = false;
	} 
	| YEAR_MINMAX {
		if ($YEAR_MINMAX.text.equals("min")) {
			$toType = YearValueType.min;
		} else {
			$toType = YearValueType.max;
		}
		$toTypeOnly = false;
	}
	| ONLY_YEAR {
		$toType = YearValueType.value;
		$toTypeOnly = true;
	}
	;
	
ruleType returns [YearType type]
	: '-' {
		$type = YearType.inclusive;
	} 
	| YEAR_TYPE {
		if ($YEAR_TYPE.text.equals("even")) {
			$type = YearType.even;
		} else if ($YEAR_TYPE.text.equals("odd")) {
			$type = YearType.odd;
		} else if ($YEAR_TYPE.text.equals("uspres")) {
			$type = YearType.uspres;
		} else if ($YEAR_TYPE.text.equals("nonpres")) {
			$type = YearType.nonpres;
		} else if ($YEAR_TYPE.text.equals("nonuspres")) {
			$type = YearType.nonuspres;
		}
	}
	;
	
ruleIn returns [int in]
	: MONTH {
		String shortMonth = $MONTH.text.substring(0, 3);
		if (shortMonth.equals("Jan")) {
			$in = Calendar.JANUARY;
		} else if (shortMonth.equals("Feb")) {
			$in = Calendar.FEBRUARY;
		} else if (shortMonth.equals("Mar")) {
			$in = Calendar.MARCH;
		} else if (shortMonth.equals("Apr")) {
			$in = Calendar.APRIL;
		} else if (shortMonth.equals("May")) {
			$in = Calendar.MAY;
		} else if (shortMonth.equals("Jun")) {
			$in = Calendar.JUNE;
		} else if (shortMonth.equals("Jul")) {
			$in = Calendar.JULY;
		} else if (shortMonth.equals("Aug")) {
			$in = Calendar.AUGUST;
		} else if (shortMonth.equals("Sep")) {
			$in = Calendar.SEPTEMBER;
		} else if (shortMonth.equals("Oct")) {
			$in = Calendar.OCTOBER;
		} else if (shortMonth.equals("Nov")) {
			$in = Calendar.NOVEMBER;
		} else if (shortMonth.equals("Dec")) {
			$in = Calendar.DECEMBER;
		} 
	};
	
ruleOn returns [int on, OnType onType, int onTypeValue]
	: d=INT {
		$on = Integer.valueOf($d.text);
		$onType = OnType.value;
	}
	| dow=LAST_DAY {
		String shortDayOfWeek;
		if ($dow.text.charAt(4) == '-') {
			shortDayOfWeek = $dow.text.substring(5, 8);
		} else {
			shortDayOfWeek = $dow.text.substring(4, 7);
		}
		
		if (shortDayOfWeek.equals("Sun")) {
			$on = Calendar.SUNDAY;
		} else if (shortDayOfWeek.equals("Mon")) {
			$on = Calendar.MONDAY;
		} else if (shortDayOfWeek.equals("Tue")) {
			$on = Calendar.TUESDAY;
		} else if (shortDayOfWeek.equals("Wed")) {
			$on = Calendar.WEDNESDAY;
		} else if (shortDayOfWeek.equals("Thu")) {
			$on = Calendar.THURSDAY;
		} else if (shortDayOfWeek.equals("Fri")) {
			$on = Calendar.FRIDAY;
		} else if (shortDayOfWeek.equals("Sat")) {
			$on = Calendar.SATURDAY;
		}
				
		$onType = OnType.last;
	}
	|
	(dow=DAY_OF_WEEK comparator=DAY_COMPARATOR value=INT) {
		String shortDayOfWeek = $dow.text.substring(0, 3);
		if (shortDayOfWeek.equals("Sun")) {
			$on = Calendar.SUNDAY;
		} else if (shortDayOfWeek.equals("Mon")) {
			$on = Calendar.MONDAY;
		} else if (shortDayOfWeek.equals("Tue")) {
			$on = Calendar.TUESDAY;
		} else if (shortDayOfWeek.equals("Wed")) {
			$on = Calendar.WEDNESDAY;
		} else if (shortDayOfWeek.equals("Thu")) {
			$on = Calendar.THURSDAY;
		} else if (shortDayOfWeek.equals("Fri")) {
			$on = Calendar.FRIDAY;
		} else if (shortDayOfWeek.equals("Sat")) {
			$on = Calendar.SATURDAY;
		}
		
		if ($comparator.text.equals("<=")) {
			$onType = OnType.let;
		} else {
			$onType = OnType.get;
		}
		
		$onTypeValue = Integer.valueOf($value.text);
	}
	;
	
ruleAt returns [int at, TimeOfDayType atType]
	: '-' {
		$at = 0;
		$atType = TimeOfDayType.wallclock;
	}
	| (positiveTime {
		$at = $positiveTime.seconds;
	} (DEFAULT_TIME_OF_DAY_SUFFIX {
		$atType = TimeOfDayType.wallclock;
		} | s=TIME_OF_DAY_SUFFIX {
			if ($s.text.equals("w")) {
				$atType = TimeOfDayType.wallclock;
			} else if ($s.text.equals("s") || $s.text.equals("g")) {
				$atType = TimeOfDayType.localStandard;
			} else if ($s.text.equals("u") || $s.text.equals("z")) {
				$atType = TimeOfDayType.universal;
			}
		} ))
	;
	
ruleSave returns [int save]
	: offset {
		$save = $offset.seconds;
	}
	;
	
ruleLetters returns [String letters]
	: '-' {
		$letters = null;
	}
	| ID {
		$letters = $ID.text;
	}
	;

zoneName
	: ID
	;

zoneGmtOffset returns [int seconds]
	: offset {$seconds = $offset.seconds;}
	;
	
zoneRules
	: '-' {
		$zoneLine::zoneRuleType = ZoneRuleType.noRuleOrSave;
	} 
	| positiveTime {
		$zoneLine::zoneRuleType = ZoneRuleType.save;
	} 
	| ID {
		$zoneLine::zoneRuleType = ZoneRuleType.rule;
	}
	;
	
zoneFormat returns [String format, String dstFormat]
	: ID {
		String formats[] = $ID.text.split("/");
		$format = formats[0];
		if (formats.length == 2) {
			$dstFormat = formats[1];
		} else {
			$dstFormat = null;
		}
	}
	| f=ID NO_DST_ID {
		$format = $f.text;
		$dstFormat = null;
	} 
	;

zoneUntil returns [int year, Integer in, Integer on, OnType onType, int onTypeValue, Integer at, TimeOfDayType atType]
	: y=INT NO_IN NO_ON NO_AT {
		$year = Integer.valueOf($y.text);
		$in = null;
		$on = null;
		$at = null;
	}
	
	| y=INT ruleIn NO_ON NO_AT {
		$year = Integer.valueOf($y.text);
		$in = $ruleIn.in;
		$on = null;
		$at = null;
	}
	| y=INT ruleIn ruleOn NO_AT {
		$year = Integer.valueOf($y.text);
		$in = $ruleIn.in;
		$on = $ruleOn.on;
		$onType = $ruleOn.onType;
		$onTypeValue = $ruleOn.onTypeValue;
		$at = null;
	}
	| y=INT ruleIn ruleOn ruleAt {
		$year = Integer.valueOf($y.text);
		$in = $ruleIn.in;
		$on = $ruleOn.on;
		$onType = $ruleOn.onType;
		$onTypeValue = $ruleOn.onTypeValue;
		$at = $ruleAt.at;
		$atType = $ruleAt.atType;
	}
	;

linkFrom
	: ID
	;
	
linkTo
	: ID
	;
	
offset returns [int seconds]
	: s='-'? positiveTime {
		if ($s != null) {
			$seconds = -$positiveTime.seconds;
		} else {
			$seconds = $positiveTime.seconds;
		}
	}
	| '-' ~INT {
		$seconds = 0;
	}
	;

positiveTime returns [int seconds]
	: (h=INT ZERO ZERO) {
		$seconds = Integer.valueOf($h.text) * 60 * 60;
	}
	| (h=INT m=INT ZERO) {
		$seconds = (Integer.valueOf($h.text) * 60 * 60) + (Integer.valueOf($m.text) * 60);
	}
	| (h=INT m=INT s=INT) {
		$seconds = (Integer.valueOf($h.text) * 60 * 60) + (Integer.valueOf($m.text) * 60) + Integer.valueOf($s.text);
	}
	;
