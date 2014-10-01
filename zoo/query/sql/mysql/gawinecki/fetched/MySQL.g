grammar MySQL;

/* create a table */

options {

	language=Java;
	output=AST;
}

import MySQLBase;

tokens {
  ACCESSIBLE_SYM 	= 'accessible' ;
  ACTION 		= 'action' ;
  ADD 			= 'add' ;
  AFTER_SYM 		= 'after' ;
  AGAINST 		= 'against' ;
  AGGREGATE_SYM 	= 'aggregate' ;
  ALGORITHM_SYM 	= 'algorithm' ;
  ALL 			= 'all' ;
  ALTER 		= 'alter' ;
  ANALYZE_SYM 		= 'analyze' ;
  AND_AND_SYM 		= '&&' ;
  AND_SYM 		= 'and' ;
  AS 			= 'as' ;
  ASC 			= 'asc' ;
  ASCII_SYM 		= 'ascii' ;
  ASENSITIVE_SYM 	= 'asensitive' ;
  AT_SYM 		= 'at' ;
  AUTHORS_SYM 		= 'authors' ;
  AUTOEXTEND_SIZE_SYM 	= 'autoextend_size' ;
  AUTO_INC 		= 'auto_increment' ;
  AVG_ROW_LENGTH 	= 'avg_row_length' ;
  AVG_SYM 		= 'avg' ;
  BACKUP_SYM 		= 'backup' ;
  BEFORE_SYM 		= 'before' ;
  BEGIN_SYM 		= 'begin' ;
  BETWEEN_SYM 		= 'between' ;
  BINARY 		= 'binary' ;
  BINLOG_SYM 		= 'binlog' ;
  BIT_SYM 		= 'bit' ;
  BLOB_SYM 		= 'blob' ;
  BLOCK_SYM 		= 'block' ;
  BOOLEAN_SYM 		= 'boolean' ;
  BOOL_SYM 		= 'bool' ;
  BOTH 			= 'both' ;
  BTREE_SYM 		= 'btree' ;
  BY 			= 'by' ;
  BYTE_SYM 		= 'byte' ;
  CACHE_SYM 		= 'cache' ;
  CALL_SYM 		= 'call' ;
  CASCADE 		= 'cascade' ;
  CASCADED 		= 'cascaded' ;
  CASE_SYM 		= 'case' ;
  CHAIN_SYM 		= 'chain' ;
  CHANGE 		= 'change' ;
  CHANGED 		= 'changed' ;
  CHARSET 		= 'charset' ;
  CHECKSUM_SYM 		= 'checksum' ;
  CHECK_SYM 		= 'check' ;
  CIPHER_SYM 		= 'cipher' ;
  CLIENT_SYM 		= 'client' ;
  CLOSE_SYM 		= 'close' ;
  COALESCE 		= 'coalesce' ;
  CODE_SYM 		= 'code' ;
  COLLATE_SYM 		= 'collate' ;
  COLLATION_SYM 	= 'collation' ;
  COLUMN_SYM 		= 'column' ;
  COMMENT_SYM 		= 'comment' ;
  COMMITTED_SYM 	= 'committed' ;
  COMMIT_SYM 		= 'commit' ;
  COMPACT_SYM 		= 'compact' ;
  COMPLETION_SYM 	= 'completion' ;
  COMPRESSED_SYM 	= 'compressed' ;
  CONCURRENT 		= 'concurrent' ;
  CONDITION_SYM 	= 'condition' ;
  CONNECTION_SYM 	= 'connection' ;
  CONSISTENT_SYM 	= 'consistent' ;
  CONSTRAINT 		= 'constraint' ;
  CONTAINS_SYM 		= 'contains' ;
  CONTEXT_SYM 		= 'context' ;
  CONTINUE_SYM 		= 'continue' ;
  CONTRIBUTORS_SYM 	= 'contributors' ;
  CONVERT_SYM 		= 'convert' ;
  CPU_SYM 		= 'cpu' ;
  CREATE 		= 'create' ;
  CROSS 		= 'cross' ;
  CUBE_SYM 		= 'cube' ;
  CURDATE 		= 'current_date' ;
  CURRENT_USER 		= 'current_user' ;
  CURSOR_SYM 		= 'cursor' ;
  CURTIME 		= 'current_time' ;
  DATAFILE_SYM 		= 'datafile' ;
  DATA_SYM 		= 'data' ;
  DATETIME 		= 'datetime' ;
  DATE_SYM 		= 'date' ;
  DAY_HOUR_SYM 		= 'day_hour' ;
  DAY_MICROSECOND_SYM 	= 'day_microsecond' ;
  DAY_MINUTE_SYM 	= 'day_minute' ;
  DAY_SECOND_SYM 	= 'day_second' ;
  DEALLOCATE_SYM 	= 'deallocate' ;     
  DECLARE_SYM 		= 'declare' ;
  DEFAULT 		= 'default' ;
  DEFINER_SYM 		= 'definer' ;
  DELAYED_SYM 		= 'delayed' ;
  DELAY_KEY_WRITE_SYM	= 'delay_key_write' ;
  DELETE_SYM 		= 'delete' ;
  DESC 			= 'desc' ;
  DES_KEY_FILE 		= 'des_key_file' ;
  DETERMINISTIC_SYM 	= 'deterministic' ;
  DIRECTORY_SYM 	= 'directory' ;
  DISABLE_SYM 		= 'disable' ;
  DISCARD 		= 'discard' ;
  DISK_SYM 		= 'disk' ;
  DIV_SYM 		= 'div' ;
  DO_SYM 		= 'do' ;
  DROP 			= 'drop' ;
  DUAL_SYM 		= 'dual' ;
  DUMPFILE 		= 'dumpfile' ;
  DUPLICATE_SYM 	= 'duplicate' ;
  DYNAMIC_SYM 		= 'dynamic' ;
  EACH_SYM 		= 'each' ;
  ELSE 			= 'else' ;
  ELSEIF_SYM 		= 'elseif' ;
  ENABLE_SYM 		= 'enable' ;
  ENCLOSED 		= 'enclosed' ;
  END 			= 'end' ;
  ENDS_SYM 		= 'ends' ;
  ENGINES_SYM 		= 'engines' ;
  ENGINE_SYM 		= 'engine' ;
  ENUM 			= 'enum' ;
  EQ 			= '=' ;
  EQUAL_SYM 		= '<=>' ;
  ERRORS 		= 'errors' ;
  ESCAPED 		= 'escaped' ;
  ESCAPE_SYM 		= 'escape' ;
  EVENTS_SYM 		= 'events' ;
  EVENT_SYM 		= 'event' ;
  EVERY_SYM 		= 'every' ;
  EXECUTE_SYM 		= 'execute' ;
  EXISTS 		= 'exists' ;
  EXIT_SYM 		= 'exit' ;
  EXPANSION_SYM 	= 'expansion' ;
  EXTENDED_SYM 		= 'extended' ;
  EXTENT_SIZE_SYM 	= 'extent_size' ;
  FALSE_SYM 		= 'false' ;
  FAST_SYM 		= 'fast' ;
  FAULTS_SYM 		= 'faults' ;
  FETCH_SYM 		= 'fetch' ;
  FILE_SYM 		= 'file' ;
  FIRST_SYM 		= 'first' ;
  FIXED_SYM 		= 'fixed' ;
  FLUSH_SYM 		= 'flush' ;
  FORCE_SYM 		= 'force' ;
  FOREIGN 		= 'foreign' ;
  FOR_SYM 		= 'for' ;
  FOUND_SYM 		= 'found' ;
  FROM 			= 'from' ;
  FULL 			= 'full' ;
  FULLTEXT_SYM 		= 'fulltext' ;
  FUNCTION_SYM 		= 'function' ;
  GE 			= '>=' ;
  GEOMETRYCOLLECTION 	= 'geometrycollection' ;
  GEOMETRY_SYM 		= 'geometry' ;
  GET_FORMAT 		= 'get_format' ;
  GLOBAL_SYM 		= 'global' ;
  GRANT 		= 'grant' ;
  GRANTS 		= 'grants' ;
  GROUP_SYM 		= 'group' ;
  GT_SYM 		= '>' ;
  HANDLER_SYM 		= 'handler' ;
  HASH_SYM 		= 'hash' ;
  HAVING 		= 'having' ;
  HELP_SYM 		= 'help' ;
  HIGH_PRIORITY 	= 'high_priority' ;
  HOSTS_SYM 		= 'hosts' ;
  HOST_SYM 		= 'host' ;
  HOUR_MICROSECOND_SYM 	= 'hour_microsecond' ;
  HOUR_MINUTE_SYM 	= 'hour_minute' ;
  HOUR_SECOND_SYM 	= 'hour_second' ;
  IDENTIFIED_SYM 	= 'identified' ;
  IF 			= 'if' ;
  IGNORE_SYM 		= 'ignore' ;
  IMPORT 		= 'import' ;
  INDEXES 		= 'indexes' ;
  INDEX_SYM 		= 'index' ;
  INFILE 		= 'infile' ;
  INITIAL_SIZE_SYM 	= 'initial_size' ;
  INNER_SYM 		= 'inner' ;
  INOUT_SYM 		= 'inout' ;
  INSENSITIVE_SYM 	= 'insensitive' ;
  INSERT 		= 'insert' ;
  INSERT_METHOD 	= 'insert_method' ;
  INSTALL_SYM 		= 'install' ;
  INTERVAL_SYM 		= 'interval' ;
  INTO 			= 'into' ;
  INVOKER_SYM 		= 'invoker' ;
  IN_SYM 		= 'in' ;
  IO_SYM 		= 'io' ;
  IPC_SYM 		= 'ipc' ;
  IS 			= 'is' ;
  ISOLATION 		= 'isolation' ;
  ISSUER_SYM 		= 'issuer' ;
  ITERATE_SYM 		= 'iterate' ;
  JOIN_SYM 		= 'join' ;
  KEYS 			= 'keys' ;
  KEY_BLOCK_SIZE 	= 'key_block_size' ;
  KEY_SYM 		= 'key' ;
  KILL_SYM 		= 'kill' ;
  LANGUAGE_SYM 		= 'language' ;
  LAST_SYM 		= 'last' ;
  LE 			= '<=' ;
  LEADING 		= 'leading' ;
  LEAVES 		= 'leaves' ;
  LEAVE_SYM 		= 'leave' ;
  LEFT 			= 'left' ;
  LESS_SYM 		= 'less' ;
  LEVEL_SYM 		= 'level' ;
  LIKE 			= 'like' ;
  LIMIT 		= 'limit' ;
  LINEAR_SYM 		= 'linear' ;
  LINES 		= 'lines' ;
  LINESTRING 		= 'linestring' ;
  LIST_SYM 		= 'list' ;
  LOAD 			= 'load' ;
  LOCAL_SYM 		= 'local' ;
  LOCKS_SYM 		= 'locks' ;
  LOCK_SYM 		= 'lock' ;
  LOGFILE_SYM 		= 'logfile' ;
  LOGS_SYM 		= 'logs' ;
  LONGBLOB 		= 'longblob' ;
  LONGTEXT 		= 'longtext' ;
  LONG_SYM 		= 'long' ;
  LOOP_SYM 		= 'loop' ;
  LOW_PRIORITY 		= 'low_priority' ;
  LT 			= '<' ;
  MASTER_CONNECT_RETRY_SYM	= 'master_connect_retry' ;
  MASTER_HOST_SYM 		= 'master_host' ;
  MASTER_LOG_FILE_SYM 		= 'master_log_file' ;
  MASTER_LOG_POS_SYM 		= 'master_log_pos' ;
  MASTER_PASSWORD_SYM 		= 'master_password' ;
  MASTER_PORT_SYM 		= 'master_port' ;
  MASTER_SERVER_ID_SYM 		= 'master_server_id' ;
  MASTER_SSL_CAPATH_SYM 	= 'master_ssl_capath' ;
  MASTER_SSL_CA_SYM 		= 'master_ssl_ca' ;
  MASTER_SSL_CERT_SYM 		= 'master_ssl_cert' ;
  MASTER_SSL_CIPHER_SYM 	= 'master_ssl_cipher' ;
  MASTER_SSL_KEY_SYM 		= 'master_ssl_key' ;
  MASTER_SSL_SYM 		= 'master_ssl' ;
  MASTER_SSL_VERIFY_SERVER_CERT_SYM 		= 'master_ssl_verify_server_cert' ;
  MASTER_SYM 		= 'master' ;
  MASTER_USER_SYM 		= 'master_user' ;
  MATCH 			= 'match' ;
  MAX_CONNECTIONS_PER_HOUR 	= 'max_connections_per_hour' ;
  MAX_QUERIES_PER_HOUR 		= 'max_queries_per_hour' ;
  MAX_ROWS 			= 'max_rows' ;
  MAX_SIZE_SYM 			= 'max_size' ;
  MAX_UPDATES_PER_HOUR 		= 'max_updates_per_hour' ;
  MAX_USER_CONNECTIONS_SYM 	= 'max_user_connections' ;
  MAX_VALUE_SYM 		= 'maxvalue' ;
  MEDIUMBLOB 		= 'mediumblob' ;
  MEDIUMTEXT 		= 'mediumtext' ;
  MEDIUM_SYM 		= 'medium' ;
  MEMORY_SYM 		= 'memory' ;
  MERGE_SYM 		= 'merge' ;
  MICROSECOND_SYM 	= 'microsecond' ;
  MIGRATE_SYM 		= 'migrate' ;
  MINUTE_MICROSECOND_SYM= 'minute_microsecond' ;
  MINUTE_SECOND_SYM 	= 'minute_second' ;
  MIN_ROWS 		= 'min_rows' ;
  MODE_SYM 		= 'mode' ;
  MODIFIES_SYM 		= 'modifies' ;
  MODIFY_SYM 		= 'modify' ;
  MOD_SYM 		= 'mod' ;
  MULTILINESTRING 	= 'multilinestring' ;
  MULTIPOINT 		= 'multipoint' ;
  MULTIPOLYGON 		= 'multipolygon' ;
  MUTEX_SYM 		= 'mutex' ;
  NAMES_SYM 		= 'names' ;
  NAME_SYM 		= 'name' ;
  NATIONAL_SYM 		= 'national' ;
  NATURAL 		= 'natural' ;
  NCHAR_SYM 		= 'nchar' ;
  NEW_SYM 		= 'new' ;
  NEXT_SYM 		= 'next' ;
  NODEGROUP_SYM 	= 'nodegroup' ;
  NONE_SYM 		= 'none' ;
  NOT			= 'not' ;
//  NOT_SYM 		= 'not' ;
  NO_SYM 		= 'no' ;
  NO_WAIT_SYM 		= 'no_wait' ;
  NO_WRITE_TO_BINLOG 	= 'no_write_to_binlog' ;
  NULL_SYM 		= 'null' ;
  NUMERIC_SYM 		= 'numeric' ;
  NVARCHAR_SYM 		= 'nvarchar' ;
  OFFSET_SYM 		= 'offset' ;
  OLD_PASSWORD 		= 'old_password' ;
  ON 			= 'on' ;
  ONE_SHOT_SYM 		= 'one_shot' ;
  ONE_SYM 		= 'one' ;
  OPEN_SYM 		= 'open' ;
  OPTIMIZE 		= 'optimize' ;
  OPTION 		= 'option' ;
  OPTIONALLY 		= 'optionally' ;
  OPTIONS_SYM 		= 'options' ;
  ORDER_SYM 		= 'order' ;
  OR_OR_SYM 		= '||' ;
  OR_SYM 		= 'or' ;
  OUTER 		= 'outer' ;
  OUTFILE 		= 'outfile' ;
  OUT_SYM 		= 'out' ;
  OWNER_SYM 		= 'owner' ;
  PACK_KEYS_SYM 	= 'pack_keys' ;
  PAGE_CHECKSUM_SYM 	= 'page_checksum' ;
  PAGE_SYM 		= 'page' ;
  PARSER_SYM 		= 'parser' ;
  PARTIAL 		= 'partial' ;
  PARTITIONING_SYM 	= 'partitioning' ;
  PARTITIONS_SYM 	= 'partitions' ;
  PARTITION_SYM 	= 'partition' ;
  PASSWORD 		= 'password' ;
  PHASE_SYM 		= 'phase' ;
  PLUGINS_SYM 		= 'plugins' ;
  PLUGIN_SYM 		= 'plugin' ;
  POINT_SYM 		= 'point' ;
  POLYGON 		= 'polygon' ;
  PORT_SYM 		= 'port' ;
  PRECISION 		= 'precision' ;
  PREPARE_SYM 		= 'prepare' ;
  PRESERVE_SYM 		= 'preserve' ;
  PREV_SYM 		= 'prev' ;
  PRIMARY_SYM 		= 'primary' ;
  PRIVILEGES 		= 'privileges' ;
  PROCEDURE 		= 'procedure' ;
  PROCESS		= 'process' ;
  PROCESSLIST_SYM	= 'processlist' ;
  PROFILES_SYM 		= 'profiles' ;
  PROFILE_SYM 		= 'profile' ;
  PURGE 		= 'purge' ;
  QUERY_SYM 		= 'query' ;
  QUICK 		= 'quick' ;
  RANGE_SYM 		= 'range' ;
  READS_SYM 		= 'reads' ;
  READ_ONLY_SYM 	= 'read_only' ;
  READ_SYM 		= 'read' ;
  READ_WRITE_SYM 	= 'read_write' ;
  REAL 			= 'real' ;
  REBUILD_SYM 		= 'rebuild' ;
  RECOVER_SYM 		= 'recover' ;
  REDOFILE_SYM 		= 'redofile' ;
  REDO_BUFFER_SIZE_SYM 	= 'redo_buffer_size' ;
  REDUNDANT_SYM 	= 'redundant' ;
  REFERENCES 		= 'references' ;
  RELAY_LOG_FILE_SYM 	= 'relay_log_file' ;
  RELAY_LOG_POS_SYM 	= 'relay_log_pos' ;
  RELEASE_SYM 		= 'release' ;
  RELOAD 		= 'reload' ;
  REMOVE_SYM 		= 'remove' ;
  RENAME 		= 'rename' ;
  REORGANIZE_SYM 	= 'reorganize' ;
  REPAIR 		= 'repair' ;
  REPEATABLE_SYM 	= 'repeatable' ;
  REPEAT_SYM 		= 'repeat' ;
  REPLACE 		= 'replace' ;
  REPLICATION 		= 'replication' ;
  REQUIRE_SYM 		= 'require' ;
  RESET_SYM 		= 'reset' ;
  RESOURCES 		= 'user_resources' ;
  RESTORE_SYM 		= 'restore' ;
  RESTRICT 		= 'restrict' ;
  RESUME_SYM 		= 'resume' ;
  RETURNS_SYM 		= 'returns' ;
  RETURN_SYM 		= 'return' ;
  REVOKE 		= 'revoke' ;
  RIGHT 		= 'right' ;
  ROLLBACK_SYM 		= 'rollback' ;
  ROLLUP_SYM 		= 'rollup' ;
  ROUTINE_SYM 		= 'routine' ;
  ROWS_SYM 		= 'rows' ;
  ROW_FORMAT_SYM 	= 'row_format' ;
  ROW_SYM 		= 'row' ;
  RTREE_SYM 		= 'rtree' ;
  SAVEPOINT_SYM 	= 'savepoint' ;
  SCHEDULE_SYM 		= 'schedule' ;
  SECOND_MICROSECOND_SYM= 'second_microsecond' ;
  SECURITY_SYM 		= 'security' ;
  SELECT_SYM 		= 'select' ;
  SENSITIVE_SYM 	= 'sensitive' ;
  SEPARATOR_SYM 	= 'separator' ;
  SERIALIZABLE_SYM 	= 'serializable' ;
  SERIAL_SYM 		= 'serial' ;
  SERVER_SYM 		= 'server' ;
  SESSION_SYM 		= 'session' ;
  SET 			= 'set' ;
  SHARE_SYM 		= 'share' ;
  SHIFT_LEFT 		= '<<' ;
  SHIFT_RIGHT 		= '>>' ;
  SHOW 			= 'show' ;
  SHUTDOWN 		= 'shutdown' ;
  SIGNED_SYM 		= 'signed' ;
  SIMPLE_SYM 		= 'simple' ;
  SLAVE 		= 'slave' ;
  SNAPSHOT_SYM 		= 'snapshot' ;
  SOCKET_SYM 		= 'socket' ;
  SONAME_SYM 		= 'soname' ;
  SOUNDS_SYM 		= 'sounds' ;
  SOURCE_SYM 		= 'source' ;
  SPATIAL_SYM 		= 'spatial' ;
  SPECIFIC_SYM 		= 'specific' ;
  SQLEXCEPTION_SYM 	= 'sqlexception' ;
  SQLSTATE_SYM 		= 'sqlstate' ;
  SQLWARNING_SYM 	= 'sqlwarning' ;
  SQL_BIG_RESULT 	= 'sql_big_result' ;
  SQL_BUFFER_RESULT 	= 'sql_buffer_result' ;
  SQL_CACHE_SYM 	= 'sql_cache' ;
  SQL_CALC_FOUND_ROWS 	= 'sql_calc_found_rows' ;
  SQL_NO_CACHE_SYM 	= 'sql_no_cache' ;
  SQL_SMALL_RESULT 	= 'sql_small_result' ;
  SQL_SYM 		= 'sql' ;
  SQL_THREAD 		= 'sql_thread' ;
  SSL_SYM 		= 'ssl' ;
  STARTING 		= 'starting' ;
  STARTS_SYM 		= 'starts' ;
  START_SYM 		= 'start' ;
  STATUS_SYM 		= 'status' ;
  STOP_SYM 		= 'stop' ;
  STORAGE_SYM 		= 'storage' ;
  STRAIGHT_JOIN 	= 'straight_join' ;
  STRING_SYM 		= 'string' ;
  SUBJECT_SYM 		= 'subject' ;
  SUBPARTITIONS_SYM 	= 'subpartitions' ;
  SUBPARTITION_SYM 	= 'subpartition' ;
  SUPER_SYM 		= 'super' ;
  SUSPEND_SYM 		= 'suspend' ;
  SWAPS_SYM 		= 'swaps' ;
  SWITCHES_SYM 		= 'switches' ;
  TABLES 		= 'tables' ;
  TABLESPACE 		= 'tablespace' ;
  TABLE_CHECKSUM_SYM 	= 'table_checksum' ;
  TABLE_SYM 		= 'table' ;
  TEMPORARY 		= 'temporary' ;
  TEMPTABLE_SYM 	= 'temptable' ;
  TERMINATED 		= 'terminated' ;
  TEXT_SYM 		= 'text' ;
  THAN_SYM 		= 'than' ;
  THEN_SYM 		= 'then' ;
  TIMESTAMP 		= 'timestamp' ;
  TIMESTAMP_ADD 	= 'timestampadd' ;
  TIMESTAMP_DIFF 	= 'timestampdiff' ;
  TIME_SYM 		= 'time' ;
  TINYBLOB 		= 'tinyblob' ;
  TINYTEXT 		= 'tinytext' ;
  TO_SYM 		= 'to' ;
  TRAILING 		= 'trailing' ;
  TRANSACTIONAL_SYM 	= 'transactional' ;
  TRANSACTION_SYM 	= 'transaction' ;
  TRIGGERS_SYM 		= 'triggers' ;
  TRIGGER_SYM 		= 'trigger' ;
  TRUE_SYM 		= 'true' ;
  TRUNCATE_SYM 		= 'truncate' ;
  TYPES_SYM 		= 'types' ;
  TYPE_SYM 		= 'type' ;
  UNCOMMITTED_SYM 	= 'uncommitted' ;
  UNDEFINED_SYM 	= 'undefined' ;
  UNDOFILE_SYM 		= 'undofile' ;
  UNDO_BUFFER_SIZE_SYM 	= 'undo_buffer_size' ;
  UNDO_SYM 		= 'undo' ;
  UNICODE_SYM 		= 'unicode' ;
  UNINSTALL_SYM 	= 'uninstall' ;
  UNION_SYM 		= 'union' ;
  UNIQUE_SYM 		= 'unique' ;
  UNKNOWN_SYM 		= 'unknown' ;
  UNLOCK_SYM 		= 'unlock' ;
  UNSIGNED 		= 'unsigned' ;
  UNTIL_SYM 		= 'until' ;
  UPDATE_SYM 		= 'update' ;
  UPGRADE_SYM 		= 'upgrade' ;
  USAGE 		= 'usage' ;
  USER 			= 'user' ;
  USE_FRM 		= 'use_frm' ;
  USE_SYM 		= 'use' ;
  USING 		= 'using' ;
  UTC_DATE_SYM 		= 'utc_date' ;
  UTC_TIMESTAMP_SYM 	= 'utc_timestamp' ;
  UTC_TIME_SYM 		= 'utc_time' ;
  VALUES 		= 'values' ;
  VALUE_SYM 		= 'value' ;
  VARBINARY 		= 'varbinary' ;
  VARIABLES 		= 'variables' ;
  VARYING 		= 'varying' ;
  VIEW_SYM 		= 'view' ;
  WAIT_SYM 		= 'wait' ;
  WARNINGS 		= 'warnings' ;
  WHEN_SYM 		= 'when' ;
  WHERE 		= 'where' ;
  WHILE_SYM 		= 'while' ;
  WITH 			= 'with' ;
  WORK_SYM 		= 'work' ;
  WRAPPER_SYM 		= 'wrapper' ;
  WRITE_SYM 		= 'write' ;
  X509_SYM 		= 'x509' ;
  XA_SYM 		= 'xa' ;
  XOR 			= 'xor' ;
  YEAR_MONTH_SYM 	= 'year_month' ;
  ZEROFILL 		= 'zerofill' ;
  SET_VAR		= ':=' ;
}



@header {
package abbr.documentation.sqlscript.parser;

import java.util.List;
import java.util.Arrays;
import java.util.TreeSet;
}

@members {
	private static final List<String> RESERVED_WORDS = Arrays.asList(new String[] { "accessible",
			"action", "add", "after", "against", "aggregate", "algorithm",
			"all", "alter", "analyze", "and", "any", "as", "asc", "ascii",
			"asensitive", "at", "authors", "auto_increment", "autoextend_size",
			"avg", "avg_row_length", "backup", "before", "begin", "between",
			"bigint", "binary", "binlog", "bit", "blob", "block", "bool",
			"boolean", "both", "btree", "by", "byte", "cache", "call",
			"cascade", "cascaded", "case", "chain", "change", "changed",
			"char", "character", "charset", "check", "checksum", "cipher",
			"client", "close", "coalesce", "code", "collate", "collation",
			"column", "columns", "comment", "commit", "committed", "compact",
			"completion", "compressed", "concurrent", "condition",
			"connection", "consistent", "constraint", "contains", "context",
			"continue", "contributors", "convert", "cpu", "create", "cross",
			"cube", "current_date", "current_time", "current_user", "cursor",
			"data", "database", "databases", "datafile", "date", "datetime",
			"day", "day_hour", "day_microsecond", "day_minute", "day_second",
			"deallocate", "dec", "decimal", "declare", "default", "definer",
			"delay_key_write", "delayed", "delete", "des_key_file", "desc",
			"describe", "deterministic", "directory", "disable", "discard",
			"disk", "distinct", "distinctrow", "div", "do", "double", "drop",
			"dual", "dumpfile", "duplicate", "dynamic", "each", "else",
			"elseif", "enable", "enclosed", "end", "ends", "engine", "engines",
			"enum", "errors", "escape", "escaped", "event", "events", "every",
			"execute", "exists", "exit", "expansion", "explain", "extended",
			"extent_size", "false", "fast", "faults", "fetch", "fields",
			"file", "first", "fixed", "float", "float4", "float8", "flush",
			"for", "force", "foreign", "found", "frac_second", "from", "full",
			"fulltext", "function", "geometry", "geometrycollection",
			"get_format", "global", "grant", "grants", "group", "handler",
			"hash", "having", "help", "high_priority", "host", "hosts", "hour",
			"hour_microsecond", "hour_minute", "hour_second", "identified",
			"if", "ignore", "import", "in", "index", "indexes", "infile",
			"initial_size", "inner", "innobase", "innodb", "inout",
			"insensitive", "insert", "insert_method", "install", "int", "int1",
			"int2", "int4", "int8", "integer", "interval", "into", "invoker",
			"io", "io_thread", "ipc", "is", "isolation", "issuer", "iterate",
			"join", "key", "key_block_size", "keys", "kill", "language",
			"last", "leading", "leave", "leaves", "left", "less", "level",
			"like", "limit", "linear", "lines", "linestring", "list", "load",
			"local", "localtime", "localtimestamp", "lock", "locks", "logfile",
			"logs", "long", "longblob", "longtext", "loop", "low_priority",
			"master", "master_connect_retry", "master_host", "master_log_file",
			"master_log_pos", "master_password", "master_port",
			"master_server_id", "master_ssl", "master_ssl_ca",
			"master_ssl_capath", "master_ssl_cert", "master_ssl_cipher",
			"master_ssl_key", "master_ssl_verify_server_cert", "master_user",
			"match", "max_connections_per_hour", "max_queries_per_hour",
			"max_rows", "max_size", "max_updates_per_hour",
			"max_user_connections", "maxvalue", "medium", "mediumblob",
			"mediumint", "mediumtext", "memory", "merge", "microsecond",
			"middleint", "migrate", "min_rows", "minute", "minute_microsecond",
			"minute_second", "mod", "mode", "modifies", "modify", "month",
			"multilinestring", "multipoint", "multipolygon", "mutex", "name",
			"names", "national", "natural", "nchar", "ndb", "ndbcluster",
			"new", "next", "no", "no_wait", "no_write_to_binlog", "nodegroup",
			"none", "not", "not", "null", "numeric", "nvarchar", "offset",
			"old_password", "on", "one", "one_shot", "open", "optimize",
			"option", "optionally", "options", "or", "order", "out", "outer",
			"outfile", "owner", "pack_keys", "page", "page_checksum", "parser",
			"partial", "partition", "partitioning", "partitions", "password",
			"phase", "plugin", "plugins", "point", "polygon", "port",
			"precision", "prepare", "preserve", "prev", "primary",
			"privileges", "procedure", "process", "processlist", "profile",
			"profiles", "purge", "quarter", "query", "quick", "range", "read",
			"read_only", "read_write", "reads", "real", "rebuild", "recover",
			"redo_buffer_size", "redofile", "redundant", "references",
			"regexp", "relay_log_file", "relay_log_pos", "relay_thread",
			"release", "reload", "remove", "rename", "reorganize", "repair",
			"repeat", "repeatable", "replace", "replication", "require",
			"reset", "restore", "restrict", "resume", "return", "returns",
			"revoke", "right", "rlike", "rollback", "rollup", "routine", "row",
			"row_format", "rows", "rtree", "savepoint", "schedule", "schema",
			"schemas", "second", "second_microsecond", "security", "select",
			"sensitive", "separator", "serial", "serializable", "server",
			"session", "set", "share", "show", "shutdown", "signed", "simple",
			"slave", "smallint", "snapshot", "socket", "some", "soname",
			"sounds", "source", "spatial", "specific", "sql", "sql_big_result",
			"sql_buffer_result", "sql_cache", "sql_calc_found_rows",
			"sql_no_cache", "sql_small_result", "sql_thread", "sql_tsi_day",
			"sql_tsi_frac_second", "sql_tsi_hour", "sql_tsi_minute",
			"sql_tsi_month", "sql_tsi_quarter", "sql_tsi_second",
			"sql_tsi_week", "sql_tsi_year", "sqlexception", "sqlstate",
			"sqlwarning", "ssl", "start", "starting", "starts", "status",
			"stop", "storage", "straight_join", "string", "subject",
			"subpartition", "subpartitions", "super", "suspend", "swaps",
			"switches", "table", "table_checksum", "tables", "tablespace",
			"temporary", "temptable", "terminated", "text", "than", "then",
			"time", "timestamp", "timestampadd", "timestampdiff", "tinyblob",
			"tinyint", "tinytext", "to", "trailing", "transaction",
			"transactional", "trigger", "triggers", "true", "truncate", "type",
			"types", "uncommitted", "undefined", "undo", "undo_buffer_size",
			"undofile", "unicode", "uninstall", "union", "unique", "unknown",
			"unlock", "unsigned", "until", "update", "upgrade", "usage", "use",
			"use_frm", "user", "user_resources", "using", "utc_date",
			"utc_time", "utc_timestamp", "value", "values", "varbinary",
			"varchar", "varcharacter", "variables", "varying", "view", "wait",
			"warnings", "week", "when", "where", "while", "with", "work",
			"wrapper", "write", "x509", "xa", "xor", "year", "year_month",
			"zerofill" });
	
	public boolean isReservedWord(String str) {
		return RESERVED_WORDS.contains(str);
		
	}
	
		public static class Node implements Comparable<Node> {

		private int line;

		public int getLine() {
			return line;
		}

		public Node(int line) {
			this.line = line;
		}

		@Override
		public int compareTo(Node o) {
			return line < o.line ? -1 : (line == o.line ? 0 : +1);
		}

	}

	public static class CommentNode extends Node {
		private String comment;

		public CommentNode(int line, String comment) {
			super(line);
			this.comment = comment;
		}

		public String getComment() {
			return comment;
		}
	}

	public static class TableNode extends Node {
		private String table;

		public TableNode(int line, String table) {
			super(line);
			this.table = table;
		}

		public String getTable() {
			return table;
		}
	}

	public static class ColumnNode extends Node {
		private String table;
		private String column;

		public ColumnNode(int line, String table, String column) {
			super(line);
			this.table = table;
			this.column = column;
		}

		public String getTable() {
			return table;
		}

		public String getColumn() {
			return column;
		}

	}

	
	TreeSet<CommentNode> comments = new TreeSet<CommentNode>();
	TreeSet<Node> identifiers = new TreeSet<Node>();
	
	public TreeSet<CommentNode> getComments() {
		return comments;
	}

	public TreeSet<Node> getIdentifiers() {
		return identifiers;
	}

	public void addComment(String comment, int line) {
		comments.add(new CommentNode(line, comment));		
	}
	
	public void addColumn(String table, String column, int line) {
		identifiers.add(new ColumnNode(line, removeQuotes(table), removeQuotes(column)));
	}
	
	public void addTable(String table, int line) {
		identifiers.add(new TableNode(line, removeQuotes(table)));
	}

	private static String removeQuotes(String str) {
		return str.replace("`","");
	}	
}

// Lexer rules for tokens which can match more then one keyword
NE:
    	'<>' | '!=' 
;

CHAR_SYM: 
	  'character' 
	| 'char'  
;

DECIMAL_SYM: 
	  'decimal' 
	| 'dec' 
;

DISTINCT: 
          'distinctrow' 	/* Access likes this */
	| 'distinct' 
;	  

MEDIUMINT:
	  'mediumint' 
	| 'middleint' 	/* For powerbuilder */
;

NOW_SYM: 
	  'localtimestamp' 
	| 'localtime' 
;

ANY_SYM:
	  'some' 
	| 'any' 
;

BIGINT:
	  'bigint'
	| 'int8' 
;

DAY_SYM:
	  'sql_tsi_day' 
	| 'day' 
;

DOUBLE_SYM:
	  'double' 
        | 'float8' ;

FLOAT_SYM:
	  'float4' 
	| 'float' 
;

MONTH_SYM:
	  'sql_tsi_month'
	| 'month' 
;

INT_SYM:
	  'integer' 
	| 'int4' 
	| 'int' 
;

REGEXP:
	  'regexp' 
	| 'rlike' 	/* Like in mSQL2 */
;

RELAY_THREAD:
	  'relay_thread' 
	| 'io_thread' 
;

WEEK_SYM:
	  'sql_tsi_week' 
	| 'week' 
;

SECOND_SYM:
	  'sql_tsi_second' 
	| 'second' 
;

NDBCLUSTER_SYM:
	  'ndbcluster'
	| 'ndb' 
;


COLUMNS:
	  'columns'
	| 'fields' 
;

FRAC_SECOND_SYM:
	  'sql_tsi_frac_second' 
	| 'frac_second' 
;

VARCHAR:   
	  'varcharacter'
	| 'varchar' 
;

TINYINT:
	  'tinyint' 
	| 'int1' 
;

SMALLINT:
	  'smallint'
	| 'int2' 
;

HOUR_SYM: 
	  'sql_tsi_hour'
	| 'hour' 
;

QUARTER_SYM: 		
	  'sql_tsi_quarter'
	| 'quarter' ;

MINUTE_SYM:
	  'sql_tsi_minute' 
	| 'minute' 
;

INNOBASE_SYM:
	  'innodb' 
	| 'innobase' 
;

YEAR_SYM:
	  'sql_tsi_year'
	| 'year' 
;

DESCRIBE:
	  'describe' 
	| 'explain' 
;


DATABASES: 		
	  'databases' 
	| 'schemas' 
;

DATABASE: 		
	  'database'
	| 'schema' 
;


// Parser rules


create:
          CREATE table_options? TABLE_SYM if_not_exists? t=table_ident
          create2[$t.text]
          
          {
          	addTable($t.text, $t.start.getLine());
          	System.out.println("table: " + $t.text + ":" + $t.start.getLine()) ;
          }
          
//        | CREATE opt_unique_or_fulltext INDEX_SYM ident key_alg ON
//          '(' key_list ')' key_options
//        | CREATE DATABASE opt_if_not_exists ident
//          opt_create_database_options
//        | CREATE
//          view_or_trigger_or_sp_or_event
//        | CREATE USER clear_privileges grant_list
//        | CREATE LOGFILE_SYM GROUP_SYM logfile_group_info 
//        | CREATE TABLESPACE tablespace_info
//        | CREATE server_def
        ;

table_options:
        table_option+
        ;

table_option:
          TEMPORARY 
        ;

create2 [String tableName]:
          '(' create2a[tableName] {}
        | create_table_options
//        opt_partitioning
          create3 {}
//        | LIKE table_ident
//        | '(' LIKE table_ident ')'
        ;

create2a [String tableName]:
          field_list[tableName] ')' create_table_options?
//          opt_partitioning
          create3 {}
//        |  opt_partitioning
//           create_select ')'
//           union_opt {}
        ;

create3:
          /* empty */ {}
//        | opt_duplicate opt_as create_select
//          union_clause {}
//        | opt_duplicate opt_as '(' create_select ')'
//          union_opt {}
        ;

if_not_exists:
        IF NOT EXISTS
        ;

field_ident:
          ident 
        | ident '.' ident '.' ident
        | ident '.' ident
        | '.' ident  /* For Delphi */
        ;
                
table_ident:
          ident
        | ident '.' ident
        | '.' ident
        ;
        
ident:	        
	  ident_sys
//        | keyword
        ;

// Identifiers
// http://dev.mysql.com/doc/refman/5.0/en/identifiers.html
ident_sys:
          IDENT_QUOTED
        | {! isReservedWord(input.LT(1).getText())}? IDENT {/* TODO check if not reserved word or special character or contains only digits */} 

        ;

// changed, because options may be space separated
create_table_options:
	create_table_option (','? create_table_option)*;



create_table_option:
            ENGINE_SYM equal? storage_engines
//        | TYPE_SYM opt_equal storage_engines
//        | MAX_ROWS opt_equal ulonglong_num
//        | MIN_ROWS opt_equal ulonglong_num
//        | AVG_ROW_LENGTH opt_equal ulong_num
//        | PASSWORD opt_equal TEXT_STRING_sys
//        | COMMENT_SYM opt_equal TEXT_STRING_sys
//        | AUTO_INC opt_equal ulonglong_num
//        | PACK_KEYS_SYM opt_equal ulong_num
//        | PACK_KEYS_SYM opt_equal DEFAULT
//        | CHECKSUM_SYM opt_equal ulong_num
//        | TABLE_CHECKSUM_SYM opt_equal ulong_num
//        | PAGE_CHECKSUM_SYM opt_equal choice
//        | DELAY_KEY_WRITE_SYM opt_equal ulong_num
//        | ROW_FORMAT_SYM opt_equal row_types
//        | UNION_SYM opt_equal '(' opt_table_list ')'
          | default_charset
//        | default_collation
//        | INSERT_METHOD opt_equal merge_insert_types
//        | DATA_SYM DIRECTORY_SYM opt_equal TEXT_STRING_sys
//        | INDEX_SYM DIRECTORY_SYM opt_equal TEXT_STRING_sys
//        | TABLESPACE ident
//        | STORAGE_SYM DISK_SYM
//        | STORAGE_SYM MEMORY_SYM
//        | CONNECTION_SYM opt_equal TEXT_STRING_sys
//        | KEY_BLOCK_SIZE opt_equal ulong_num
//        | TRANSACTIONAL_SYM opt_equal choice
        ;

default_charset:
          DEFAULT? charset equal? charset_name_or_default
        ;

equal:
          EQ 
        | SET_VAR 
        ;

storage_engines:
          ident_or_text
        ;

ident_or_text:
          ident           
        | text_string_sys 
//        | LEX_HOSTNAME 
        ;

/////// column list

field_list [String tableName]:
          field_list_item[tableName] (',' field_list_item[tableName])*
        ;

field_list_item [String tableName]:
          column_def[tableName]
        | key_def
        ;

column_def [String tableName]:
          field_spec[tableName] // check_constraint?
//        | field_spec references
        ;

key_def:
          key_type ident? key_alg '(' key_list ')' key_options
        | constraint? constraint_key_type ident? key_alg '(' key_list ')' key_options
        | constraint? FOREIGN KEY_SYM ident? '(' key_list ')' references
//        | constraint check_constraint?
//        | constraint? check_constraint
     
        ;

key_alg:
          init_key_options
        | init_key_options key_using_alg
        ;

init_key_options:
        ;

key_options:
          key_opts?
        ;

key_opts:
          key_opt+
        ;

key_using_alg:
          USING btree_or_rtree     
        | TYPE_SYM btree_or_rtree  
        ;

key_opt:
          key_using_alg
        | KEY_BLOCK_SIZE equal? ulong_num
        | WITH PARSER_SYM ident_sys
        ;

btree_or_rtree:
          BTREE_SYM 
        | RTREE_SYM 
        | HASH_SYM  
        ;

key_list:
          key_part order_dir (',' key_part order_dir )*
        ;

key_part:
          ident
        | ident '(' NUM ')'
        ;

order_dir:
        (
           ASC 
         | DESC 
        )?
        ;



//check_constraint:
//          CHECK_SYM expr
//        ;

constraint:
          CONSTRAINT ident? 
        ;


        
field_spec [String tableName]:
          c=field_ident 
          	{ 
          	        addColumn(tableName, $c.text, $c.start.getLine());
          		System.out.println("column: " + tableName + "." + $c.text + ":" + $c.start.getLine() ); 
          	}
          type attribute?
        ;

type:
          int_type field_length? field_options 
        | real_type precision? field_options 
        | FLOAT_SYM float_options field_options 
        | BIT_SYM
        | BIT_SYM field_length
        | BOOL_SYM
        | BOOLEAN_SYM
        | char2 field_length binary?
        | char2 binary?
        | nchar field_length bin_mod?
        | nchar bin_mod?
        | BINARY field_length
        | BINARY
        | varchar field_length binary?
        | nvarchar field_length bin_mod?
        | VARBINARY field_length
        | YEAR_SYM field_length? field_options
        | DATE_SYM
        | TIME_SYM
        | TIMESTAMP field_length?
        | DATETIME
        | TINYBLOB           | BLOB_SYM field_length
        | spatial_type
        | MEDIUMBLOB
        | LONGBLOB
        | LONG_SYM VARBINARY
        | LONG_SYM varchar binary?
        | TINYTEXT binary?
        | TEXT_SYM field_length? binary?
        | MEDIUMTEXT binary?
        | LONGTEXT binary?
        | DECIMAL_SYM float_options field_options
        | NUMERIC_SYM float_options field_options
        | FIXED_SYM float_options field_options
        | ENUM
        | SET
        | LONG_SYM binary?
        | SERIAL_SYM
        ;

spatial_type:
          GEOMETRY_SYM        
        | GEOMETRYCOLLECTION  
        | POINT_SYM
        | MULTIPOINT          
        | LINESTRING          
        | MULTILINESTRING     
        | POLYGON             
        | MULTIPOLYGON        
        ;

char2:
          CHAR_SYM 
        ;

nchar:
          NCHAR_SYM 
        | NATIONAL_SYM CHAR_SYM 
        ;

varchar:
          char2 VARYING {}
        | VARCHAR {}
        ;

nvarchar:
          NATIONAL_SYM VARCHAR {}
        | NVARCHAR_SYM {}
        | NCHAR_SYM VARCHAR {}
        | NATIONAL_SYM CHAR_SYM VARYING {}
        | NCHAR_SYM VARYING {}
        ;

int_type:
          INT_SYM   
        | TINYINT   
        | SMALLINT  
        | MEDIUMINT 
        | BIGINT    
        ;

real_type:
          REAL
        | DOUBLE_SYM
        | DOUBLE_SYM PRECISION
        ;

float_options:
        (
          field_length 
         
          | precision

        )?
        ;

precision:
          '(' NUM ',' NUM ')'
        ;
        
        
field_options:
        field_option*
        ;

field_option:
          SIGNED_SYM {}
        | UNSIGNED 
        | ZEROFILL 
        ;

field_length:
          '(' LONG_NUM ')'      
        | '(' ULONGLONG_NUM ')' 
        | '(' DECIMAL_NUM ')'   
        | '(' NUM ')'           
        ;

attribute_list:
        attribute+ attribute_with_key | attribute_with_key attribute+  | attribute*
        ;

attribute:
          DEFAULT now_or_signed_literal 
//        | NULL_SYM   // TODO resolved it
        | NOT NULL_SYM 
//        | ON UPDATE_SYM NOW_SYM optional_braces
        | AUTO_INC 
//        | SERIAL_SYM DEFAULT VALUE_SYM
//        | COMMENT_SYM TEXT_STRING_sys 
//        | COLLATE_SYM collation_name
        ;
        
// removed from attribute rule, because caused non-determinism -- a column can either be a primary key or simply a key not both        
// obviously the order of attributes is not important
attribute_with_key:	        
          PRIMARY_SYM? KEY_SYM 
        | UNIQUE_SYM KEY_SYM?
;

now_or_signed_literal:
          NOW_SYM?
        | signed_literal
        ;

// made from optional_braces
braces:
         '(' ')'
        ;


charset:
          CHAR_SYM SET {}
        | CHARSET {}
        ;
        
on_delete:
          on_delete_list 
        ;

on_delete_list:
          on_delete_item+
        ;

on_delete_item:
          ON DELETE_SYM delete_option
        | ON UPDATE_SYM delete_option
        | MATCH FULL       
        | MATCH PARTIAL    
        | MATCH SIMPLE_SYM 
        ;

delete_option:
          RESTRICT      
        | CASCADE       
        | SET NULL_SYM  
        | NO_SYM ACTION 
        | SET DEFAULT   
        ;

key_type:
          key_or_index 
        | FULLTEXT_SYM key_or_index? 
        | SPATIAL_SYM key_or_index?
        ;

constraint_key_type:
          PRIMARY_SYM KEY_SYM 
        | UNIQUE_SYM key_or_index?
        ;

key_or_index:
          KEY_SYM {}
        | INDEX_SYM {}
        ;

keys_or_index:
          KEYS {}
        | INDEX_SYM {}
        | INDEXES {}
        ;

opt_unique_or_fulltext:
	  UNIQUE_SYM   
        | FULLTEXT_SYM 
        | SPATIAL_SYM
;

// moved from yacc lexer (UNDERSCORE_CHARSET) to parser
underscore_charset: 
	'_' charset_name	
;        

charset_name:
          ident_or_text
        | BINARY 
        ;

charset_name_or_default:
          charset_name 
        | DEFAULT    
        ;
        
binary:
          ASCII_SYM BINARY? 
        | BYTE_SYM
        | UNICODE_SYM BINARY?
        | charset charset_name bin_mod?
        | BINARY bin_charset?
        ;

bin_mod:
        BINARY 
        ;

bin_charset:
          ASCII_SYM 
        | UNICODE_SYM
        | charset charset_name 
        ;

references:
          REFERENCES table_ident
          opt_ref_list
        ;

opt_ref_list:
          on_delete? {}
        | '(' ref_list ')' on_delete? {}
        ;

ref_list:
          ident (',' ident)*
	;
        
        
signed_literal:
          literal //_without_null  // introduced instead of literal to avoid non-determinism via attribute_list
        | '+' NUM_literal 
        | '-' NUM_literal
        ;

literal:
          text_literal 
        | NUM_literal 
        | NULL_SYM
        | FALSE_SYM
        | TRUE_SYM
        | HEX_NUM
        | BIN_NUM 
        | underscore_charset HEX_NUM
        | underscore_charset BIN_NUM
        | DATE_SYM text_literal 
        | TIME_SYM text_literal 
        | TIMESTAMP text_literal
        ;

// introduced to avoid non-determinism
literal_without_null:
          text_literal 
        | NUM_literal 
        | FALSE_SYM
        | TRUE_SYM
        | HEX_NUM
        | BIN_NUM 
        | underscore_charset HEX_NUM
        | underscore_charset BIN_NUM
        | DATE_SYM text_literal 
        | TIME_SYM text_literal 
        | TIMESTAMP text_literal
	;

// Common definitions

text_literal:
          (TEXT_STRING | NCHAR_STRING | underscore_charset TEXT_STRING) (text_string_literal)* 
        ;

// just TEST_STRING requiring conversion if not in a given charset        
text_string_sys:
          TEXT_STRING
        ;

// just a TEXT_STring REQUIRING CONVERSION IF NOT IN PARTICULAR CHARSET
text_string_literal:
          TEXT_STRING
        ;
        
ulong_num:
          NUM           
        | HEX_NUM       
        | LONG_NUM      
        | ULONGLONG_NUM 
        | DECIMAL_NUM   
        | FLOAT_NUM     
        ;

real_ulong_num:
          NUM           
        | HEX_NUM       
        | LONG_NUM      
        | ULONGLONG_NUM 
        | dec_num_error 
        ;

ulonglong_num:
          NUM           
        | ULONGLONG_NUM 
        | LONG_NUM      
        | DECIMAL_NUM   
        | FLOAT_NUM     
        ;

real_ulonglong_num:
          NUM           
        | ULONGLONG_NUM 
        | LONG_NUM      
        | dec_num_error 
        ;

dec_num_error:
          dec_num
//          { my_parse_error(ER(ER_ONLY_INTEGERS_ALLOWED)); }
        ;

dec_num:
          DECIMAL_NUM
        | FLOAT_NUM
        ;



// Lexer


// LEXER_TOKENS

//        IDENT IDENT_QUOTED TEXT_STRING DECIMAL_NUM FLOAT_NUM NUM LONG_NUM HEX_NUM
//	LEX_HOSTNAME ULONGLONG_NUM field_ident select_alias ident ident_or_text
//        UNDERSCORE_CHARSET IDENT_sys TEXT_STRING_sys TEXT_STRING_literal
//	NCHAR_STRING opt_component key_cache_name
//        sp_opt_label BIN_NUM label_ident

// TODO

sql_script:	
	(create ';')+ EOF
;

comments_in_sql_script:	
        (  
          c=SL_COMMENT 
          	{ 
          		addComment($c.text, $c.line);
          		System.out.println("sl_comment: " + $c.text + ":" + $c.line); 
          	}
        | c=ML_COMMENT 
        	{ 
        		addComment($c.text, $c.line);
        		System.out.println("ml_comment: " + $c.text + ":" + $c.line); 
        	}
        )* EOF
	;        
