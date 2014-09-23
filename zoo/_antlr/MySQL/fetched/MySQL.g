grammar MySQL;

options 
{
	language=C;
	output=AST;
	backtrack=true;
}

tokens 
{
}

@header 
{
}

@members 
{

}

@lexer::header 
{
}

@lexer::members 
{
}

fragment A_ :	'a' | 'A';
fragment B_ :	'b' | 'B';
fragment C_ :	'c' | 'C';
fragment D_ :	'd' | 'D';
fragment E_ :	'e' | 'E';
fragment F_ :	'f' | 'F';
fragment G_ :	'g' | 'G';
fragment H_ :	'h' | 'H';
fragment I_ :	'i' | 'I';
fragment J_ :	'j' | 'J';
fragment K_ :	'k' | 'K';
fragment L_ :	'l' | 'L';
fragment M_ :	'm' | 'M';
fragment N_ :	'n' | 'N';
fragment O_ :	'o' | 'O';
fragment P_ :	'p' | 'P';
fragment Q_ :	'q' | 'Q';
fragment R_ :	'r' | 'R';
fragment S_ :	's' | 'S';
fragment T_ :	't' | 'T';
fragment U_ :	'u' | 'U';
fragment V_ :	'v' | 'V';
fragment W_ :	'w' | 'W';
fragment X_ :	'x' | 'X';
fragment Y_ :	'y' | 'Y';
fragment Z_ :	'z' | 'Z';




ABS				: A_ B_ S_ ;
ACCESSIBLE_SYM			: A_ C_ C_ E_ S_ S_ I_ B_ L_ E_  ;
ACOS				: A_ C_ O_ S_ ;
ACTION				: A_ C_ T_ I_ O_ N_  ;
ADD_SYM				: A_ D_ D_  ;
ADDDATE				: A_ D_ D_ D_ A_ T_ E_  ;
ADDTIME				: A_ D_ D_ T_ I_ M_ E_  ;
AES_DECRYPT			: A_ E_ S_ '_' D_ E_ C_ R_ Y_ P_ T_  ;
AES_ENCRYPT			: A_ E_ S_ '_' E_ N_ C_ R_ Y_ P_ T_  ;
AFTER_SYM			: A_ F_ T_ E_ R_  ;
AGAINST				: A_ G_ A_ I_ N_ S_ T_  ;
AGGREGATE_SYM			: A_ G_ G_ R_ E_ G_ A_ T_ E_  ;
ALGORITHM_SYM			: A_ L_ G_ O_ R_ I_ T_ H_ M_  ;
ALL				: A_ L_ L_  ;
ALTER				: A_ L_ T_ E_ R_  ;
ANALYZE_SYM			: A_ N_ A_ L_ Y_ Z_ E_  ;
ANY				: A_ N_ Y_ ;
ARMSCII8			: A_ R_ M_ S_ C_ I_ I_ '8'  ;
AS_SYM				: A_ S_  ;
ASC				: A_ S_ C_  ;
ASCII_SYM			: A_ S_ C_ I_ I_  ;
ASENSITIVE_SYM			: A_ S_ E_ N_ S_ I_ T_ I_ V_ E_  ;
ASIN				: A_ S_ I_ N_  ;
AT_SYM				: A_ T_  ;
ATAN				: A_ T_ A_ N_  ;
ATAN2				: A_ T_ A_ N_ '2'  ;
AUTHORS_SYM			: A_ U_ T_ H_ O_ R_ S_  ;
AUTO_INCREMENT			: A_ U_ T_ O_  '_' I_ N_ C_ R_ E_ M_ E_ N_ T_  ;
AUTOEXTEND_SIZE_SYM		: A_ U_ T_ O_ E_ X_ T_ E_ N_ D_  '_' S_ I_ Z_ E_  ;
AVG				: A_ V_ G_;
AVG_ROW_LENGTH			: A_ V_ G_  '_' R_ O_ W_  '_' L_ E_ N_ G_ T_ H_  ;
BACKUP_SYM			: B_ A_ C_ K_ U_ P_  ;
BEFORE_SYM			: B_ E_ F_ O_ R_ E_  ;
BEGIN_SYM			: B_ E_ G_ I_ N_  ;
BENCHMARK			: B_ E_ N_ C_ H_ M_ A_ R_ K_  ;
BETWEEN				: B_ E_ T_ W_ E_ E_ N_  ;
BIG5				: B_ I_ G_ '5'  ;
BIGINT				: B_ I_ G_ I_ N_ T_  ;
BIN				: B_ I_ N_  ;
BINARY				: B_ I_ N_ A_ R_ Y_  ;
BINLOG_SYM			: B_ I_ N_ L_ O_ G_  ;
BIT_AND				: B_ I_ T_ '_' A_ N_ D_  ;
BIT_LENGTH			: B_ I_ T_ '_' L_ E_ N_ G_ T_ H_;
BIT_OR				: B_ I_ T_ '_' O_ R_  ;
BIT_SYM				: B_ I_ T_  ;
BIT_XOR				: B_ I_ T_ '_' X_ O_ R_  ;
BLOB_SYM			: B_ L_ O_ B_  ;
BLOCK_SYM			: B_ L_ O_ C_ K_  ;
BOOL_SYM			: B_ O_ O_ L_  ;
BOOLEAN_SYM			: B_ O_ O_ L_ E_ A_ N_  ;
BOTH				: B_ O_ T_ H_  ;
BTREE_SYM			: B_ T_ R_ E_ E_  ;
BY_SYM				: B_ Y_ ;
BYTE_SYM			: B_ Y_ T_ E_  ;
CACHE_SYM			: C_ A_ C_ H_ E_  ;
CALL_SYM			: C_ A_ L_ L_  ;
CASCADE				: C_ A_ S_ C_ A_ D_ E_  ;
CASCADED			: C_ A_ S_ C_ A_ D_ E_ D_  ;
CASE_SYM			: C_ A_ S_ E_  ;
CAST_SYM			: C_ A_ S_ T_  ;
CEIL				: C_ E_ I_ L_  ;
CEILING				: C_ E_ I_ L_ I_ N_ G_  ;
CHAIN_SYM			: C_ H_ A_ I_ N_  ;
CHANGE				: C_ H_ A_ N_ G_ E_  ;
CHANGED				: C_ H_ A_ N_ G_ E_ D_  ;
CHAR				: C_ H_ A_ R_  ;
CHAR_LENGTH			: (C_ H_ A_ R_ '_' L_ E_ N_ G_ T_ H_) | (C_ H_ A_ R_ A_ C_ T_ E_ R_ '_' L_ E_ N_ G_ T_ H_) ;
CHARACTER_SYM			: C_ H_ A_ R_ A_ C_ T_ E_ R_  ;
CHARSET				: C_ H_ A_ R_ S_ E_ T_  ;
CHECK_SYM			: C_ H_ E_ C_ K_  ;
CHECKSUM_SYM			: C_ H_ E_ C_ K_ S_ U_ M_  ;
CIPHER_SYM			: C_ I_ P_ H_ E_ R_  ;
CLIENT_SYM			: C_ L_ I_ E_ N_ T_  ;
CLOSE_SYM			: C_ L_ O_ S_ E_ ;
COALESCE			: C_ O_ A_ L_ E_ S_ C_ E_  ;
CODE_SYM			: C_ O_ D_ E_  ;
COERCIBILITY			: C_ O_ E_ R_ C_ I_ B_ I_ L_ I_ T_ Y_  ;
COLLATE_SYM			: C_ O_ L_ L_ A_ T_ E_  ;
COLLATION			: C_ O_ L_ L_ A_ T_ I_ O_ N_  ;
COLUMN_FORMAT			: C_ O_ L_ U_ M_ N_ '_' F_ O_ R_ M_ A_ T_  ;
COLUMN_SYM			: C_ O_ L_ U_ M_ N_  ;
COLUMNS_SYM			: C_ O_ L_ U_ M_ N_ S_  ;
COMMENT_SYM			: C_ O_ M_ M_ E_ N_ T_  ;
COMMIT_SYM			: C_ O_ M_ M_ I_ T_  ;
COMMITTED_SYM			: C_ O_ M_ M_ I_ T_ T_ E_ D_  ;
COMPACT_SYM			: C_ O_ M_ P_ A_ C_ T_  ;
COMPLETION_SYM			: C_ O_ M_ P_ L_ E_ T_ I_ O_ N_  ;
COMPRESS			: C_ O_ M_ P_ R_ E_ S_ S_  ;
COMPRESSED_SYM			: C_ O_ M_ P_ R_ E_ S_ S_ E_ D_  ;
CONCAT				: C_ O_ N_ C_ A_ T_  ;
CONCAT_WS			: C_ O_ N_ C_ A_ T_ '_' W_ S_  ;
CONCURRENT			: C_ O_ N_ C_ U_ R_ R_ E_ N_ T_  ;
CONDITION_SYM			: C_ O_ N_ D_ I_ T_ I_ O_ N_  ;
CONNECTION_ID			: C_ O_ N_ N_ E_ C_ T_ I_ O_ N_ '_' I_ D_  ;
CONNECTION_SYM			: C_ O_ N_ N_ E_ C_ T_ I_ O_ N_  ;
CONSISTENT_SYM			: C_ O_ N_ S_ I_ S_ T_ E_ N_ T_  ;
CONSTRAINT			: C_ O_ N_ S_ T_ R_ A_ I_ N_ T_  ;
CONTAINS_SYM			: C_ O_ N_ T_ A_ I_ N_ S_  ;
CONTEXT_SYM			: C_ O_ N_ T_ E_ X_ T_  ;
CONTINUE_SYM			: C_ O_ N_ T_ I_ N_ U_ E_  ;
CONTRIBUTORS_SYM		: C_ O_ N_ T_ R_ I_ B_ U_ T_ O_ R_ S_  ;
CONV				: C_ O_ N_ V_  ;
CONVERT_SYM			: C_ O_ N_ V_ E_ R_ T_  ;
CONVERT_TZ			: C_ O_ N_ V_ E_ R_ T_ '_' T_ Z_  ;
COPY_SYM			: C_ O_ P_ Y_  ;
COS				: C_ O_ S_  ;
COT				: C_ O_ T_  ;
COUNT				: C_ O_ U_ N_ T_  ;
CP1250				: C_ P_ '1250'  ;
CP1251				: C_ P_ '1251'  ;
CP1256				: C_ P_ '1256'  ;
CP1257				: C_ P_ '1257'  ;
CP850				: C_ P_ '850'  ;
CP852				: C_ P_ '852'  ;
CP866				: C_ P_ '866'  ;
CP932				: C_ P_ '932'  ;
CPU_SYM				: C_ P_ U_  ;
CRC32				: C_ R_ C_ '32'  ;
CREATE				: C_ R_ E_ A_ T_ E_ ;
CROSECOND			: C_ R_ O_ S_ E_ C_ O_ N_ D_  ;
CROSS				: C_ R_ O_ S_ S_  ;
CUBE_SYM			: C_ U_ B_ E_  ;
CURDATE				: (C_ U_ R_ D_ A_ T_ E_) | (C_ U_ R_ R_ E_ N_ T_ '_' D_ A_ T_ E_) ;
CURRENT_TIMESTAMP		: C_ U_ R_ R_ E_ N_ T_ '_' T_ I_ M_ E_ S_ T_ A_ M_ P_  ;
CURRENT_USER			: C_ U_ R_ R_ E_ N_ T_ '_' U_ S_ E_ R_ ;
CURSOR_SYM			: C_ U_ R_ S_ O_ R_  ;
CURTIME				: (C_ U_ R_ T_ I_ M_ E_) | (C_ U_ R_ R_ E_ N_ T_ '_' T_ I_ M_ E_) ;
DATABASE			: D_ A_ T_ A_ B_ A_ S_ E_  ;
DATAFILE_SYM			: D_ A_ T_ A_ F_ I_ L_ E_  ;
DATA_SYM			: D_ A_ T_ A_  ;
DATE_ADD			: D_ A_ T_ E_ '_' A_ D_ D_  ;
DATE_FORMAT			: D_ A_ T_ E_ '_' F_ O_ R_ M_ A_ T_  ;
DATE_SUB			: (D_ A_ T_ E_ '_' S_ U_ B_) | (S_ U_ B_ D_ A_ T_ E_) ;
DATE_SYM			: D_ A_ T_ E_  ;
DATEDIFF			: D_ A_ T_ E_ D_ I_ F_ F_  ;
DATETIME			: D_ A_ T_ E_ T_ I_ M_ E_  ;
DAY_SYM				: D_ A_ Y_  ;
DAY_HOUR			: D_ A_ Y_  '_' H_ O_ U_ R_  ;
DAY_MICROSECOND			: D_ A_ Y_  '_' M_ I_ C_ R_ O_ S_ E_ C_ O_ N_ D_  ;
DAY_MINUTE			: D_ A_ Y_  '_' M_ I_ N_ U_ T_ E_  ;
DAY_SECOND			: D_ A_ Y_  '_' S_ E_ C_ O_ N_ D_  ;
DAYNAME				: D_ A_ Y_ N_ A_ M_ E_  ;
DAYOFMONTH			: (D_ A_ Y_ O_ F_ M_ O_ N_ T_ H_) | (D_ A_ Y_) ;
DAYOFWEEK			: D_ A_ Y_ O_ F_ W_ E_ E_ K_  ;
DAYOFYEAR			: D_ A_ Y_ O_ F_ Y_ E_ A_ R_  ;
DEALLOCATE_SYM			: D_ E_ A_ L_ L_ O_ C_ A_ T_ E_  ; 
DEC8				: D_ E_ C_ '8'  ;
DECIMAL_SYM			: D_ E_ C_ I_ M_ A_ L_  ;
DECLARE_SYM			: D_ E_ C_ L_ A_ R_ E_  ;
DECODE				: D_ E_ C_ O_ D_ E_  ;
DEFAULT				: D_ E_ F_ A_ U_ L_ T_  ;
DEFINER				: D_ E_ F_ I_ N_ E_ R_ ;
DEGREES				: D_ E_ G_ R_ E_ E_ S_  ;
DELAY_KEY_WRITE_SYM		: D_ E_ L_ A_ Y_  '_' K_ E_ Y_  '_' W_ R_ I_ T_ E_  ;
DELAYED_SYM			: D_ E_ L_ A_ Y_ E_ D_  ;
DELETE_SYM			: D_ E_ L_ E_ T_ E_ ;
DES_DECRYPT			: D_ E_ S_ '_' D_ E_ C_ R_ Y_ P_ T_  ;
DES_ENCRYPT			: D_ E_ S_ '_' E_ N_ C_ R_ Y_ P_ T_  ;
DES_KEY_FILE			: D_ E_ S_  '_' K_ E_ Y_  '_' F_ I_ L_ E_  ;
DESC				: D_ E_ S_ C_  ;
DETERMINISTIC_SYM		: D_ E_ T_ E_ R_ M_ I_ N_ I_ S_ T_ I_ C_  ;
DIRECTORY_SYM			: D_ I_ R_ E_ C_ T_ O_ R_ Y_  ;
DISABLE_SYM			: D_ I_ S_ A_ B_ L_ E_  ;
DISCARD				: D_ I_ S_ C_ A_ R_ D_  ;
DISK_SYM			: D_ I_ S_ K_  ;
DISTINCT			: D_ I_ S_ T_ I_ N_ C_ T_ ;
DISTINCTROW			: D_ I_ S_ T_ I_ N_ C_ T_ R_ O_ W_ ;
DO_SYM				: D_ O_  ;
DOUBLE_SYM			: D_ O_ U_ B_ L_ E_  ;
DROP				: D_ R_ O_ P_  ;
DUAL_SYM			: D_ U_ A_ L_  ;
DUMPFILE			: D_ U_ M_ P_ F_ I_ L_ E_  ;
DUPLICATE_SYM			: D_ U_ P_ L_ I_ C_ A_ T_ E_  ;
DYNAMIC_SYM			: D_ Y_ N_ A_ M_ I_ C_  ;
EACH_SYM			: E_ A_ C_ H_  ;
ELSE_SYM			: E_ L_ S_ E_  ;
ELSIF_SYM			: E_ L_ S_ I_ F_ ;
ELT				: E_ L_ T_  ;
ENABLE_SYM			: E_ N_ A_ B_ L_ E_  ;
ENCLOSED			: E_ N_ C_ L_ O_ S_ E_ D_  ;
ENCODE				: E_ N_ C_ O_ D_ E_  ;
ENCRYPT				: E_ N_ C_ R_ Y_ P_ T_  ;
END_SYM				: E_ N_ D_ ;
ENDS_SYM			: E_ N_ D_ S_  ;
ENGINE_SYM			: E_ N_ G_ I_ N_ E_  ;
ENGINES_SYM			: E_ N_ G_ I_ N_ E_ S_  ;
ENUM				: E_ N_ U_ M_  ;
ERRORS				: E_ R_ R_ O_ R_ S_  ;
ESCAPE_SYM			: E_ S_ C_ A_ P_ E_  ;
ESCAPED				: E_ S_ C_ A_ P_ E_ D_  ;
EUCJPMS				: E_ U_ C_ J_ P_ M_ S_ ;
EUCKR				: E_ U_ C_ K_ R_  ;
EVENT_SYM			: E_ V_ E_ N_ T_  ;
EVENTS_SYM			: E_ V_ E_ N_ T_ S_  ;
EVERY_SYM			: E_ V_ E_ R_ Y_  ;
EXCHANGE_SYM			: E_ X_ C_ H_ A_ N_ G_ E_ '_' S_ Y_ M_  ;
EXECUTE_SYM			: E_ X_ E_ C_ U_ T_ E_  ;
EXCLUSIVE_SYM			: E_ X_ C_ L_ U_ S_ I_ V_ E_  ;
EXISTS				: E_ X_ I_ S_ T_ S_ ;
EXIT_SYM			: E_ X_ I_ T_  ;
EXP				: E_ X_ P_  ;
EXPANSION_SYM			: E_ X_ P_ A_ N_ S_ I_ O_ N_  ;
EXPORT_SET			: E_ X_ P_ O_ R_ T_ '_' S_ E_ T_  ;
EXTENDED_SYM			: E_ X_ T_ E_ N_ D_ E_ D_  ;
EXTENT_SIZE_SYM			: E_ X_ T_ E_ N_ T_  '_' S_ I_ Z_ E_  ;
EXTRACT				: E_ X_ T_ R_ A_ C_ T_  ;
FALSE_SYM			: F_ A_ L_ S_ E_ ;
FAST_SYM			: F_ A_ S_ T_  ;
FAULTS_SYM			: F_ A_ U_ L_ T_ S_  ;
FIELDS_SYM			: F_ I_ E_ L_ D_ S_  ;
FETCH_SYM			: F_ E_ T_ C_ H_  ;
FIELD				: F_ I_ E_ L_ D_  ;
FILE_SYM			: F_ I_ L_ E_  ;
FIND_IN_SET			: F_ I_ N_ D_ '_' I_ N_ '_' S_ E_ T_  ;
FIRST_SYM			: F_ I_ R_ S_ T_  ;
FIXED_SYM			: F_ I_ X_ E_ D_  ;
FLOAT_SYM			: F_ L_ O_ A_ T_  ;
FLOOR				: F_ L_ O_ O_ R_  ;
FLUSH_SYM			: F_ L_ U_ S_ H_  ;
FOR_SYM				: F_ O_ R_  ;
FORCE_SYM			: F_ O_ R_ C_ E_  ;
FOREIGN				: F_ O_ R_ E_ I_ G_ N_  ;
FORMAT				: F_ O_ R_ M_ A_ T_  ;
FOUND_ROWS			: F_ O_ U_ N_ D_ '_' R_ O_ W_ S_  ;
FOUND_SYM			: F_ O_ U_ N_ D_  ;
FROM				: F_ R_ O_ M_  ;
FROM_BASE64			: F_ R_ O_ M_ '_' B_ A_ S_ E_ '64';
FROM_DAYS			: F_ R_ O_ M_ '_' D_ A_ Y_ S_  ;
FROM_UNIXTIME			: F_ R_ O_ M_ '_' U_ N_ I_ X_ T_ I_ M_ E_  ;
FULL				: F_ U_ L_ L_  ;
FULLTEXT_SYM			: F_ U_ L_ L_ T_ E_ X_ T_  ;
FUNCTION_SYM			: F_ U_ N_ C_ T_ I_ O_ N_  ;
GB2312				: G_ B_ '2312'  ;
GBK				: G_ B_ K_  ;
GEOMETRY_SYM			: G_ E_ O_ M_ E_ T_ R_ Y_  ;
GEOMETRYCOLLECTION		: G_ E_ O_ M_ E_ T_ R_ Y_ C_ O_ L_ L_ E_ C_ T_ I_ O_ N_  ;
GEOSTD8				: G_ E_ O_ S_ T_ D_ '8'  ;
GET_FORMAT			: G_ E_ T_ '_' F_ O_ R_ M_ A_ T_  ;
GET_LOCK			: G_ E_ T_ '_' L_ O_ C_ K_  ;
GLOBAL_SYM			: G_ L_ O_ B_ A_ L_  ;
GRANT				: G_ R_ A_ N_ T_  ;
GRANTS				: G_ R_ A_ N_ T_ S_  ;
GREEK				: G_ R_ E_ E_ K_  ;
GROUP_CONCAT			: G_ R_ O_ U_ P_ '_' C_ O_ N_ C_ A_ T_  ;
GROUP_SYM			: G_ R_ O_ U_ P_  ;
HANDLER_SYM			: H_ A_ N_ D_ L_ E_ R_  ;
HASH_SYM			: H_ A_ S_ H_  ;
HAVING				: H_ A_ V_ I_ N_ G_  ;
HEBREW				: H_ E_ B_ R_ E_ W_  ;
HELP_SYM			: H_ E_ L_ P_  ;
HEX				: H_ E_ X_  ;
HIGH_PRIORITY			: H_ I_ G_ H_  '_' P_ R_ I_ O_ R_ I_ T_ Y_  ;
HOST_SYM			: H_ O_ S_ T_  ;
HOSTS_SYM			: H_ O_ S_ T_ S_  ;
HOUR				: H_ O_ U_ R_  ;
HOUR_MICROSECOND		: H_ O_ U_ R_  '_' M_ I_ C_ R_ O_ S_ E_ C_ O_ N_ D_  ;
HOUR_MINUTE			: H_ O_ U_ R_  '_' M_ I_ N_ U_ T_ E_  ;
HOUR_SECOND			: H_ O_ U_ R_  '_' S_ E_ C_ O_ N_ D_  ;
HP8				: H_ P_ '8'  ;
IDENTIFIED_SYM			: I_ D_ E_ N_ T_ I_ F_ I_ E_ D_  ;
IF				: I_ F_  ;
IFNULL				: I_ F_ N_ U_ L_ L_  ;
IGNORE_SYM			: I_ G_ N_ O_ R_ E_  ;
IMPORT				: I_ M_ P_ O_ R_ T_  ;
IN_SYM				: I_ N_  ;
INDEX_SYM			: I_ N_ D_ E_ X_  ;
INDEXES				: I_ N_ D_ E_ X_ E_ S_  ;
INET_ATON			: I_ N_ E_ T_ '_' A_ T_ O_ N_  ;
INET_NTOA			: I_ N_ E_ T_ '_' N_ T_ O_ A_  ;
INFILE				: I_ N_ F_ I_ L_ E_  ;
INITIAL_SIZE_SYM		: I_ N_ I_ T_ I_ A_ L_  '_' S_ I_ Z_ E_  ;
INNER_SYM			: I_ N_ N_ E_ R_  ;
INOUT_SYM			: I_ N_ O_ U_ T_  ;
INPLACE_SYM			: I_ N_ P_ L_ A_ C_ E_   ;
INSENSITIVE_SYM			: I_ N_ S_ E_ N_ S_ I_ T_ I_ V_ E_  ;
INSERT				: I_ N_ S_ E_ R_ T_  ;
INSERT_METHOD			: I_ N_ S_ E_ R_ T_  '_' M_ E_ T_ H_ O_ D_  ;
INSTALL_SYM			: I_ N_ S_ T_ A_ L_ L_  ;
INSTR				: I_ N_ S_ T_ R_  ;
INT_SYM				: I_ N_ T_  ;
INTEGER_SYM			: I_ N_ T_ E_ G_ E_ R_  ;
INTERVAL_SYM			: I_ N_ T_ E_ R_ V_ A_ L_  ;
INTO				: I_ N_ T_ O_  ;
INVOKER_SYM			: I_ N_ V_ O_ K_ E_ R_  ;
IO_SYM				: I_ O_  ;
IPC_SYM				: I_ P_ C_  ;
IS_FREE_LOCK			: I_ S_ '_' F_ R_ E_ E_ '_' L_ O_ C_ K_  ;
IS_SYM				: I_ S_  ;
IS_USED_LOCK			: I_ S_ '_' U_ S_ E_ D_ '_' L_ O_ C_ K_  ;
ISOLATION			: I_ S_ O_ L_ A_ T_ I_ O_ N_  ;
ISSUER_SYM			: I_ S_ S_ U_ E_ R_  ;
ITERATE_SYM			: I_ T_ E_ R_ A_ T_ E_  ;
JOIN_SYM			: J_ O_ I_ N_  ;
KEY_BLOCK_SIZE			: K_ E_ Y_  '_' B_ L_ O_ C_ K_  '_' S_ I_ Z_ E_  ;
KEY_SYM				: K_ E_ Y_  ;
KEYBCS2				: K_ E_ Y_ B_ C_ S_ '2'  ;
KEYS				: K_ E_ Y_ S_  ;
KILL_SYM			: K_ I_ L_ L_  ;
KOI8R				: K_ O_ I_ '8' R_  ;
KOI8U				: K_ O_ I_ '8' U_  ;
LANGUAGE			: L_ A_ N_ G_ U_ A_ G_ E_ ;
LAST_DAY			: L_ A_ S_ T_ '_' D_ A_ Y_  ;
LAST_INSERT_ID			: L_ A_ S_ T_ '_' I_ N_ S_ E_ R_ T_ '_' I_ D_  ;
LAST_SYM			: L_ A_ S_ T_  ;
LATIN1_BIN			: L_ A_ T_ I_ N_ '1_' B_ I_ N_  ;
LATIN1_GENERAL_CS		: L_ A_ T_ I_ N_ '1_' G_ E_ N_ E_ R_ A_ L_ '_' C_ S_  ;
LATIN1				: L_ A_ T_ I_ N_ '1'  ;
LATIN2				: L_ A_ T_ I_ N_ '2'  ;
LATIN5				: L_ A_ T_ I_ N_ '5'  ;
LATIN7				: L_ A_ T_ I_ N_ '7'  ;
LEADING				: L_ E_ A_ D_ I_ N_ G_  ;
LEAVE_SYM			: L_ E_ A_ V_ E_  ;
LEAVES				: L_ E_ A_ V_ E_ S_  ;
LEFT				: L_ E_ F_ T_  ;
LENGTH				: (L_ E_ N_ G_ T_ H_) | (O_ C_ T_ E_ T_ '_' L_ E_ N_ G_ T_ H_) ;
LESS_SYM			: L_ E_ S_ S_  ;
LEVEL_SYM			: L_ E_ V_ E_ L_  ;
LIKE_SYM			: L_ I_ K_ E_  ;
LIMIT				: L_ I_ M_ I_ T_  ;
LINEAR_SYM			: L_ I_ N_ E_ A_ R_  ;
LINES				: L_ I_ N_ E_ S_  ;
LINESTRING			: L_ I_ N_ E_ S_ T_ R_ I_ N_ G_  ;
LIST_SYM			: L_ I_ S_ T_  ;
LN				: L_ N_  ;
LOAD				: L_ O_ A_ D_  ;
LOAD_FILE			: L_ O_ A_ D_ '_' F_ I_ L_ E_  ;
LOCAL_SYM			: L_ O_ C_ A_ L_  ;
LOCATE				: (L_ O_ C_ A_ T_ E_) | (P_ O_ S_ I_ T_ I_ O_ N_)  ;
LOCK				: L_ O_ C_ K_ ;
LOCKS_SYM			: L_ O_ C_ K_ S_  ;
LOG				: L_ O_ G_  ;
LOG10				: L_ O_ G_ '10'  ;
LOG2				: L_ O_ G_ '2'  ;
LOGFILE_SYM			: L_ O_ G_ F_ I_ L_ E_  ;
LOGS_SYM			: L_ O_ G_ S_  ;
LONG_SYM			: L_ O_ N_ G_  ;
LONGBLOB			: L_ O_ N_ G_ B_ L_ O_ B_  ;
LONGTEXT			: L_ O_ N_ G_ T_ E_ X_ T_  ;
LOOP_SYM			: L_ O_ O_ P_  ;
LOW_PRIORITY			: L_ O_ W_  '_' P_ R_ I_ O_ R_ I_ T_ Y_  ;
LOWER				: (L_ O_ W_ E_ R_) | (L_ C_ A_ S_ E_) ;
LPAD				: L_ P_ A_ D_  ;
LTRIM				: L_ T_ R_ I_ M_  ;
MACCE				: M_ A_ C_ C_ E_  ;
MACROMAN			: M_ A_ C_ R_ O_ M_ A_ N_  ;
MAKE_SET			: M_ A_ K_ E_ '_' S_ E_ T_  ;
MAKEDATE			: M_ A_ K_ E_ D_ A_ T_ E_  ;
MAKETIME			: M_ A_ K_ E_ T_ I_ M_ E_  ;
MASTER_CONNECT_RETRY		: M_ A_ S_ T_ E_ R_  '_' C_ O_ N_ N_ E_ C_ T_  '_' R_ E_ T_ R_ Y_  ;
MASTER_HOST_SYM			: M_ A_ S_ T_ E_ R_  '_' H_ O_ S_ T_  ;
MASTER_LOG_FILE_SYM		: M_ A_ S_ T_ E_ R_  '_' L_ O_ G_  '_' F_ I_ L_ E_  ;
MASTER_LOG_POS_SYM		: M_ A_ S_ T_ E_ R_  '_' L_ O_ G_  '_' P_ O_ S_  ;
MASTER_PASSWORD_SYM		: M_ A_ S_ T_ E_ R_  '_' P_ A_ S_ S_ W_ O_ R_ D_  ;
MASTER_PORT_SYM			: M_ A_ S_ T_ E_ R_  '_' P_ O_ R_ T_  ;
MASTER_POS_WAIT			: M_ A_ S_ T_ E_ R_ '_' P_ O_ S_ '_' W_ A_ I_ T_  ;
MASTER_SERVER_ID_SYM		: M_ A_ S_ T_ E_ R_  '_' S_ E_ R_ V_ E_ R_  '_' I_ D_  ;
MASTER_SSL_CA_SYM		: M_ A_ S_ T_ E_ R_  '_' S_ S_ L_  '_' C_ A_  ;
MASTER_SSL_CAPATH_SYM		: M_ A_ S_ T_ E_ R_  '_' S_ S_ L_  '_' C_ A_ P_ A_ T_ H_  ;
MASTER_SSL_CERT_SYM		: M_ A_ S_ T_ E_ R_  '_' S_ S_ L_  '_' C_ E_ R_ T_  ;
MASTER_SSL_CIPHER_SYM		: M_ A_ S_ T_ E_ R_  '_' S_ S_ L_  '_' C_ I_ P_ H_ E_ R_  ;
MASTER_SSL_KEY_SYM		: M_ A_ S_ T_ E_ R_  '_' S_ S_ L_  '_' K_ E_ Y_  ;
MASTER_SSL_SYM			: M_ A_ S_ T_ E_ R_  '_' S_ S_ L_  ;
MASTER_SSL_VERIFY_SERVER_CERT	: M_ A_ S_ T_ E_ R_  '_' S_ S_ L_  '_' V_ E_ R_ I_ F_ Y_  '_' S_ E_ R_ V_ E_ R_  '_' C_ E_ R_ T_  ;
MASTER_SYM			: M_ A_ S_ T_ E_ R_  ;
MASTER_USER_SYM			: M_ A_ S_ T_ E_ R_  '_' U_ S_ E_ R_  ;
MATCH				: M_ A_ T_ C_ H_  ;
MAX_SYM				: M_ A_ X_  ;
MAX_CONNECTIONS_PER_HOUR	: M_ A_ X_  '_' C_ O_ N_ N_ E_ C_ T_ I_ O_ N_ S_  '_' P_ E_ R_  '_' H_ O_ U_ R_  ;
MAX_QUERIES_PER_HOUR		: M_ A_ X_  '_' Q_ U_ E_ R_ I_ E_ S_  '_' P_ E_ R_  '_' H_ O_ U_ R_  ;
MAX_ROWS			: M_ A_ X_  '_' R_ O_ W_ S_  ;
MAX_SIZE_SYM			: M_ A_ X_  '_' S_ I_ Z_ E_  ;
MAX_UPDATES_PER_HOUR		: M_ A_ X_  '_' U_ P_ D_ A_ T_ E_ S_  '_' P_ E_ R_  '_' H_ O_ U_ R_  ;
MAX_USER_CONNECTIONS_SYM	: M_ A_ X_  '_' U_ S_ E_ R_  '_' C_ O_ N_ N_ E_ C_ T_ I_ O_ N_ S_  ;
MAXVALUE_SYM			: M_ A_ X_ V_ A_ L_ U_ E_  ;
MD5				: M_ D_ '5'  ;
MEDIUM_SYM			: M_ E_ D_ I_ U_ M_  ;
MEDIUMBLOB			: M_ E_ D_ I_ U_ M_ B_ L_ O_ B_  ;
MEDIUMINT			: M_ E_ D_ I_ U_ M_ I_ N_ T_  ;
MEDIUMTEXT			: M_ E_ D_ I_ U_ M_ T_ E_ X_ T_  ;
MEMORY_SYM			: M_ E_ M_ O_ R_ Y_  ;
MERGE_SYM			: M_ E_ R_ G_ E_  ;
MICROSECOND			: M_ I_ C_ R_ O_ S_ E_ C_ O_ N_ D_  ;
MID				: M_ I_ D_  ;
MIGRATE_SYM			: M_ I_ G_ R_ A_ T_ E_  ;
MIN_SYM				: M_ I_ N_  ;
MIN_ROWS			: M_ I_ N_  '_' R_ O_ W_ S_  ;
MINUTE				: M_ I_ N_ U_ T_ E_  ;
MINUTE_MICROSECOND		: M_ I_ N_ U_ T_ E_  '_' M_ I_ C_ R_ O_ S_ E_ C_ O_ N_ D_  ;
MINUTE_SECOND			: M_ I_ N_ U_ T_ E_  '_' S_ E_ C_ O_ N_ D_  ;
MOD				: M_ O_ D_  ;
MODE_SYM			: M_ O_ D_ E_  ;
MODIFIES_SYM			: M_ O_ D_ I_ F_ I_ E_ S_  ;
MODIFY_SYM			: M_ O_ D_ I_ F_ Y_  ;
MONTH				: M_ O_ N_ T_ H_  ;
MONTHNAME			: M_ O_ N_ T_ H_ N_ A_ M_ E_  ;
MULTILINESTRING			: M_ U_ L_ T_ I_ L_ I_ N_ E_ S_ T_ R_ I_ N_ G_  ;
MULTIPOINT			: M_ U_ L_ T_ I_ P_ O_ I_ N_ T_  ;
MULTIPOLYGON			: M_ U_ L_ T_ I_ P_ O_ L_ Y_ G_ O_ N_  ;
MUTEX_SYM			: M_ U_ T_ E_ X_  ;
NAME_CONST			: N_ A_ M_ E_ '_' C_ O_ N_ S_ T_  ;
NAME_SYM			: 'NAME'  ;
NAMES_SYM			: 'NAMES'  ;
NATIONAL_SYM			: N_ A_ T_ I_ O_ N_ A_ L_  ;
NATURAL				: N_ A_ T_ U_ R_ A_ L_  ;
NCHAR_SYM			: N_ C_ H_ A_ R_  ;
NEW_SYM				: N_ E_ W_  ;
NEXT_SYM			: N_ E_ X_ T_  ;
NO_SYM				: N_ O_  ;
NO_WAIT_SYM			: N_ O_  '_' W_ A_ I_ T_  ;
NO_WRITE_TO_BINLOG		: N_ O_  '_' W_ R_ I_ T_ E_  '_' T_ O_  '_' B_ I_ N_ L_ O_ G_  ;
NODEGROUP_SYM			: N_ O_ D_ E_ G_ R_ O_ U_ P_  ;
NONE_SYM			: N_ O_ N_ E_  ;
NOT_SYM				: (N_ O_ T_) | ('!') ;
NOW				: (N_ O_ W_) | (L_ O_ C_ A_ L_ T_ I_ M_ E_) | (L_ O_ C_ A_ L_ T_ I_ M_ E_ S_ T_ A_ M_ P_) | (C_ U_ R_ R_ E_ N_ T_ '_' T_ I_ M_ E_ S_ T_ A_ M_ P_);
NULL_SYM			: N_ U_ L_ L_  ;
NUMERIC_SYM			: N_ U_ M_ E_ R_ I_ C_  ;
NVARCHAR_SYM			: N_ V_ A_ R_ C_ H_ A_ R_  ;
OCT				: O_ C_ T_  ;
OFFSET_SYM			: O_ F_ F_ S_ E_ T_  ;
OJ_SYM				: O_ J_  ;
OLD_PASSWORD			: O_ L_ D_  '_' P_ A_ S_ S_ W_ O_ R_ D_  ;
ON				: O_ N_  ;
ONE_SHOT_SYM			: O_ N_ E_  '_' S_ H_ O_ T_  ;
ONE_SYM				: O_ N_ E_  ;
OPEN_SYM			: O_ P_ E_ N_  ;
OPTIMIZE			: O_ P_ T_ I_ M_ I_ Z_ E_  ;
OPTION				: O_ P_ T_ I_ O_ N_  ;
OPTIONALLY			: O_ P_ T_ I_ O_ N_ A_ L_ L_ Y_  ;
OPTIONS_SYM			: O_ P_ T_ I_ O_ N_ S_  ;
ORD				: O_ R_ D_  ;
ORDER_SYM			: O_ R_ D_ E_ R_  ;
OUT_SYM				: O_ U_ T_  ;
OUTER				: O_ U_ T_ E_ R_  ;
OUTFILE				: O_ U_ T_ F_ I_ L_ E_  ;
OWNER_SYM			: O_ W_ N_ E_ R_  ;
PACK_KEYS_SYM			: P_ A_ C_ K_  '_' K_ E_ Y_ S_  ;
PAGE_CHECKSUM_SYM		: P_ A_ G_ E_  '_' C_ H_ E_ C_ K_ S_ U_ M_  ;
PAGE_SYM			: P_ A_ G_ E_  ;
PARSER_SYM			: P_ A_ R_ S_ E_ R_  ;
PARTIAL				: P_ A_ R_ T_ I_ A_ L_  ;
PARTITION_SYM			: P_ A_ R_ T_ I_ T_ I_ O_ N_  ;
PARTITIONING_SYM		: P_ A_ R_ T_ I_ T_ I_ O_ N_ I_ N_ G_  ;
PARTITIONS_SYM			: P_ A_ R_ T_ I_ T_ I_ O_ N_ S_  ;
PASSWORD			: P_ A_ S_ S_ W_ O_ R_ D_  ;
PERIOD_ADD			: P_ E_ R_ I_ O_ D_ '_' A_ D_ D_  ;
PERIOD_DIFF			: P_ E_ R_ I_ O_ D_ '_' D_ I_ F_ F_  ;
PHASE_SYM			: P_ H_ A_ S_ E_  ;
PI				: P_ I_  ;
PLUGIN_SYM			: P_ L_ U_ G_ I_ N_  ;
PLUGINS_SYM			: P_ L_ U_ G_ I_ N_ S_  ;
POINT_SYM			: P_ O_ I_ N_ T_  ;
POLYGON				: P_ O_ L_ Y_ G_ O_ N_  ;
PORT_SYM			: P_ O_ R_ T_  ;
POW				: P_ O_ W_  ;
POWER				: P_ O_ W_ E_ R_  ;
PRECISION			: P_ R_ E_ C_ I_ S_ I_ O_ N_  ;
PREPARE_SYM			: P_ R_ E_ P_ A_ R_ E_  ;
PRESERVE_SYM			: P_ R_ E_ S_ E_ R_ V_ E_  ;
PREV_SYM			: P_ R_ E_ V_  ;
PRIMARY_SYM			: P_ R_ I_ M_ A_ R_ Y_  ;
PRIVILEGES			: P_ R_ I_ V_ I_ L_ E_ G_ E_ S_  ;
PROCEDURE			: P_ R_ O_ C_ E_ D_ U_ R_ E_  ;
PROCESS				: P_ R_ O_ C_ E_ S_ S_  ;
PROCESSLIST_SYM			: P_ R_ O_ C_ E_ S_ S_ L_ I_ S_ T_  ;
PROFILE_SYM			: P_ R_ O_ F_ I_ L_ E_  ;
PROFILES_SYM			: P_ R_ O_ F_ I_ L_ E_ S_  ;
PURGE				: P_ U_ R_ G_ E_  ;
QUARTER				: Q_ U_ A_ R_ T_ E_ R_  ;
QUERY_SYM			: Q_ U_ E_ R_ Y_  ;
QUICK				: Q_ U_ I_ C_ K_  ;
QUOTE				: Q_ U_ O_ T_ E_  ;
RADIANS				: R_ A_ D_ I_ A_ N_ S_  ;
RAND				: R_ A_ N_ D_  ;
RANGE_SYM			: R_ A_ N_ G_ E_  ;
READ_ONLY_SYM			: R_ E_ A_ D_  '_' O_ N_ L_ Y_  ;
READ_SYM			: R_ E_ A_ D_  ;
READ_WRITE_SYM			: R_ E_ A_ D_  '_' W_ R_ I_ T_ E_  ;
READS_SYM			: R_ E_ A_ D_ S_  ;
REAL				: R_ E_ A_ L_  ;
REBUILD_SYM			: R_ E_ B_ U_ I_ L_ D_  ;
RECOVER_SYM			: R_ E_ C_ O_ V_ E_ R_  ;
REDO_BUFFER_SIZE_SYM		: R_ E_ D_ O_  '_' B_ U_ F_ F_ E_ R_  '_' S_ I_ Z_ E_  ;
REDOFILE_SYM			: R_ E_ D_ O_ F_ I_ L_ E_  ;
REDUNDANT_SYM			: R_ E_ D_ U_ N_ D_ A_ N_ T_  ;
REFERENCES			: R_ E_ F_ E_ R_ E_ N_ C_ E_ S_  ;
REGEXP				: (R_ E_ G_ E_ X_ P_) | (R_ L_ I_ K_ E_);
RELAY_LOG_FILE_SYM		: R_ E_ L_ A_ Y_  '_' L_ O_ G_  '_' F_ I_ L_ E_  ;
RELAY_LOG_POS_SYM		: R_ E_ L_ A_ Y_  '_' L_ O_ G_  '_' P_ O_ S_  ;
RELEASE_LOCK			: R_ E_ L_ E_ A_ S_ E_ '_' L_ O_ C_ K_  ;
RELEASE_SYM			: R_ E_ L_ E_ A_ S_ E_  ;
RELOAD				: R_ E_ L_ O_ A_ D_  ;
REMOVE_SYM			: R_ E_ M_ O_ V_ E_  ;
RENAME				: R_ E_ N_ A_ M_ E_  ;
REORGANIZE_SYM			: R_ E_ O_ R_ G_ A_ N_ I_ Z_ E_  ;
REPAIR				: R_ E_ P_ A_ I_ R_  ;
REPEAT				: R_ E_ P_ E_ A_ T_  ;
REPEATABLE_SYM			: R_ E_ P_ E_ A_ T_ A_ B_ L_ E_  ;
REPLACE				: R_ E_ P_ L_ A_ C_ E_  ;
REPLICATION			: R_ E_ P_ L_ I_ C_ A_ T_ I_ O_ N_  ;
REQUIRE_SYM			: R_ E_ Q_ U_ I_ R_ E_  ;
RESET_SYM			: R_ E_ S_ E_ T_  ;
RESOURCES			: U_ S_ E_ R_  '_' R_ E_ S_ O_ U_ R_ C_ E_ S_  ;
RESTORE_SYM			: R_ E_ S_ T_ O_ R_ E_  ;
RESTRICT			: R_ E_ S_ T_ R_ I_ C_ T_  ;
RESUME_SYM			: R_ E_ S_ U_ M_ E_  ;
RETURN_SYM			: R_ E_ T_ U_ R_ N_  ;
RETURNS_SYM			: R_ E_ T_ U_ R_ N_ S_  ;
REVERSE				: R_ E_ V_ E_ R_ S_ E_  ;
REVOKE				: R_ E_ V_ O_ K_ E_  ;
RIGHT				: R_ I_ G_ H_ T_  ;
ROLLBACK			: R_ O_ L_ L_ B_ A_ C_ K_ ;
ROLLUP_SYM			: R_ O_ L_ L_ U_ P_  ;
ROUND				: R_ O_ U_ N_ D_  ;
ROUTINE_SYM			: R_ O_ U_ T_ I_ N_ E_  ;
ROW_FORMAT_SYM			: R_ O_ W_  '_' F_ O_ R_ M_ A_ T_  ;
ROW_SYM				: R_ O_ W_  ;
ROWS_SYM			: R_ O_ W_ S_  ;
RPAD				: R_ P_ A_ D_  ;
RTREE_SYM			: R_ T_ R_ E_ E_  ;
RTRIM				: R_ T_ R_ I_ M_  ;
SAVEPOINT			: S_ A_ V_ E_ P_ O_ I_ N_ T_ ;
SCHEDULE_SYM			: S_ C_ H_ E_ D_ U_ L_ E_  ;
SCHEMA				: S_ C_ H_ E_ M_ A_  ;
SEC_TO_TIME			: S_ E_ C_ '_' T_ O_ '_' T_ I_ M_ E_  ;
SECOND				: S_ E_ C_ O_ N_ D_  ;
SECOND_MICROSECOND		: S_ E_ C_ O_ N_ D_  '_' M_ I_ C_ R_ O_ S_ E_ C_ O_ N_ D_  ;
SECURITY_SYM			: S_ E_ C_ U_ R_ I_ T_ Y_  ;
SELECT				: S_ E_ L_ E_ C_ T_ ;
SENSITIVE_SYM			: S_ E_ N_ S_ I_ T_ I_ V_ E_  ;
SEPARATOR_SYM			: S_ E_ P_ A_ R_ A_ T_ O_ R_  ;
SERIAL_SYM			: S_ E_ R_ I_ A_ L_  ;
SERIALIZABLE_SYM		: S_ E_ R_ I_ A_ L_ I_ Z_ A_ B_ L_ E_  ;
SERVER_SYM			: S_ E_ R_ V_ E_ R_  ;
SESSION_SYM			: S_ E_ S_ S_ I_ O_ N_  ;
SESSION_USER			: S_ E_ S_ S_ I_ O_ N_ '_' U_ S_ E_ R_  ;
SET_SYM				: S_ E_ T_ ;
SHARED_SYM			: S_ H_ A_ R_ E_ D_  ;
SHARE_SYM			: S_ H_ A_ R_ E_  ;
SHOW				: S_ H_ O_ W_  ;
SHUTDOWN			: S_ H_ U_ T_ D_ O_ W_ N_  ;
SIGN				: S_ I_ G_ N_  ;
SIGNED_SYM			: S_ I_ G_ N_ E_ D_  ;
SIMPLE_SYM			: S_ I_ M_ P_ L_ E_  ;
SIN				: S_ I_ N_  ;
SJIS				: S_ J_ I_ S_  ;
SLAVE				: S_ L_ A_ V_ E_  ;
SLEEP				: S_ L_ E_ E_ P_  ;
SMALLINT			: S_ M_ A_ L_ L_ I_ N_ T_  ;
SNAPSHOT_SYM			: S_ N_ A_ P_ S_ H_ O_ T_  ;
SOCKET_SYM			: S_ O_ C_ K_ E_ T_  ;
SONAME_SYM			: S_ O_ N_ A_ M_ E_  ;
SOUNDEX				: S_ O_ U_ N_ D_ E_ X_  ;
SOUNDS_SYM			: S_ O_ U_ N_ D_ S_  ;
SOURCE_SYM			: S_ O_ U_ R_ C_ E_  ;
SPACE				: S_ P_ A_ C_ E_  ;
SPATIAL_SYM			: S_ P_ A_ T_ I_ A_ L_  ;
SPECIFIC_SYM			: S_ P_ E_ C_ I_ F_ I_ C_  ;
SQL_BIG_RESULT			: S_ Q_ L_  '_' B_ I_ G_  '_' R_ E_ S_ U_ L_ T_  ;
SQL_BUFFER_RESULT		: S_ Q_ L_  '_' B_ U_ F_ F_ E_ R_  '_' R_ E_ S_ U_ L_ T_  ;
SQL_CACHE_SYM			: S_ Q_ L_  '_' C_ A_ C_ H_ E_  ;
SQL_CALC_FOUND_ROWS		: S_ Q_ L_  '_' C_ A_ L_ C_  '_' F_ O_ U_ N_ D_  '_' R_ O_ W_ S_  ;
SQL_NO_CACHE_SYM		: S_ Q_ L_  '_' N_ O_  '_' C_ A_ C_ H_ E_  ;
SQL_SMALL_RESULT		: S_ Q_ L_  '_' S_ M_ A_ L_ L_  '_' R_ E_ S_ U_ L_ T_  ;
SQL_SYM				: S_ Q_ L_ ;
SQL_THREAD			: S_ Q_ L_  '_' T_ H_ R_ E_ A_ D_  ;
SQLEXCEPTION_SYM		: S_ Q_ L_ E_ X_ C_ E_ P_ T_ I_ O_ N_  ;
SQLSTATE_SYM			: S_ Q_ L_ S_ T_ A_ T_ E_  ;
SQLWARNING_SYM			: S_ Q_ L_ W_ A_ R_ N_ I_ N_ G_  ;
SQRT				: S_ Q_ R_ T_  ;
SSL_SYM				: S_ S_ L_  ;
START_SYM			: S_ T_ A_ R_ T_  ;
STARTING			: S_ T_ A_ R_ T_ I_ N_ G_  ;
STATS_AUTO_RECALC		: S_ T_ A_ T_ S_ '_' A_ U_ T_ O_ '_' R_ E_ C_ A_ L_ C_  ;
STATS_PERSISTENT		: S_ T_ A_ T_ S_ '_' P_ E_ R_ S_ I_ S_ T_ E_ N_ T_  ;
STARTS_SYM			: S_ T_ A_ R_ T_ S_  ;
STATUS_SYM			: S_ T_ A_ T_ U_ S_  ;
STD				: S_ T_ D_  ;
STDDEV				: S_ T_ D_ D_ E_ V_  ;
STDDEV_POP			: S_ T_ D_ D_ E_ V_ '_' P_ O_ P_  ;
STDDEV_SAMP			: S_ T_ D_ D_ E_ V_ '_' S_ A_ M_ P_  ;
STOP_SYM			: S_ T_ O_ P_  ;
STORAGE_SYM			: S_ T_ O_ R_ A_ G_ E_  ;
STR_TO_DATE			: S_ T_ R_ '_' T_ O_ '_' D_ A_ T_ E_  ;
STRAIGHT_JOIN			: S_ T_ R_ A_ I_ G_ H_ T_  '_' J_ O_ I_ N_  ;
STRCMP				: S_ T_ R_ C_ M_ P_;
STRING_SYM			: S_ T_ R_ I_ N_ G_  ;
SUBJECT_SYM			: S_ U_ B_ J_ E_ C_ T_  ;
SUBPARTITION_SYM		: S_ U_ B_ P_ A_ R_ T_ I_ T_ I_ O_ N_  ;
SUBPARTITIONS_SYM		: S_ U_ B_ P_ A_ R_ T_ I_ T_ I_ O_ N_ S_  ;
SUBSTRING			: (S_ U_ B_ S_ T_ R_ I_ N_ G_) | (S_ U_ B_ S_ T_ R_) ;
SUBSTRING_INDEX			: S_ U_ B_ S_ T_ R_ I_ N_ G_ '_' I_ N_ D_ E_ X_  ;
SUBTIME				: S_ U_ B_ T_ I_ M_ E_  ;
SUM				: S_ U_ M_  ;
SUPER_SYM			: S_ U_ P_ E_ R_  ;
SUSPEND_SYM			: S_ U_ S_ P_ E_ N_ D_  ;
SWAPS_SYM			: S_ W_ A_ P_ S_  ;
SWE7				: S_ W_ E_ '7'  ;
SWITCHES_SYM			: S_ W_ I_ T_ C_ H_ E_ S_  ;
SYSDATE				: S_ Y_ S_ D_ A_ T_ E_  ;
SYSTEM_USER			: S_ Y_ S_ T_ E_ M_ '_' U_ S_ E_ R_  ;
TABLE				: T_ A_ B_ L_ E_ ;
TABLE_CHECKSUM_SYM		: T_ A_ B_ L_ E_  '_' C_ H_ E_ C_ K_ S_ U_ M_  ;
TABLES				: T_ A_ B_ L_ E_ S_  ;
TABLESPACE			: T_ A_ B_ L_ E_ S_ P_ A_ C_ E_  ;
TAN				: T_ A_ N_  ;
TEMPORARY			: T_ E_ M_ P_ O_ R_ A_ R_ Y_  ;
TEMPTABLE_SYM			: T_ E_ M_ P_ T_ A_ B_ L_ E_  ;
TERMINATED			: T_ E_ R_ M_ I_ N_ A_ T_ E_ D_  ;
TEXT_SYM			: T_ E_ X_ T_  ;
THAN_SYM			: T_ H_ A_ N_  ;
THEN_SYM			: T_ H_ E_ N_  ;
TIME_FORMAT			: T_ I_ M_ E_ '_' F_ O_ R_ M_ A_ T_  ;
TIME_SYM			: T_ I_ M_ E_  ;
TIME_TO_SEC			: T_ I_ M_ E_ '_' T_ O_ '_' S_ E_ C_  ;
TIMEDIFF			: T_ I_ M_ E_ D_ I_ F_ F_  ;
TIMESTAMP			: T_ I_ M_ E_ S_ T_ A_ M_ P_  ;
TIMESTAMPADD			: T_ I_ M_ E_ S_ T_ A_ M_ P_ A_ D_ D_  ;
TIMESTAMPDIFF			: T_ I_ M_ E_ S_ T_ A_ M_ P_ D_ I_ F_ F_  ;
TINYBLOB			: T_ I_ N_ Y_ B_ L_ O_ B_  ;
TINYINT				: T_ I_ N_ Y_ I_ N_ T_  ;
TINYTEXT			: T_ I_ N_ Y_ T_ E_ X_ T_  ;
TIS620				: T_ I_ S_ '620'  ;
TO_BASE64			: T_ O_ '_' B_ A_ S_ E_ '64';
TO_DAYS				: T_ O_ '_' D_ A_ Y_ S_  ;
TO_SECONDS			: T_ O_ '_' S_ E_ C_ O_ N_ D_ S_;
TO_SYM				: T_ O_  ;
TRAILING			: T_ R_ A_ I_ L_ I_ N_ G_  ;
TRANSACTION			: T_ R_ A_ N_ S_ A_ C_ T_ I_ O_ N_ ;
TRANSACTIONAL_SYM		: T_ R_ A_ N_ S_ A_ C_ T_ I_ O_ N_ A_ L_  ;
TRIGGER_SYM			: T_ R_ I_ G_ G_ E_ R_  ;
TRIGGERS_SYM			: T_ R_ I_ G_ G_ E_ R_ S_  ;
TRIM				: T_ R_ I_ M_  ;
TRUE_SYM			: T_ R_ U_ E_ ;
TRUNCATE			: T_ R_ U_ N_ C_ A_ T_ E_  ;
TYPE_SYM			: 'TYPE'  ;
TYPES_SYM			: T_ Y_ P_ E_ S_  ;
UCS2				: U_ C_ S_ '2';
UJIS				: U_ J_ I_ S_  ;
UNCOMMITTED_SYM			: U_ N_ C_ O_ M_ M_ I_ T_ T_ E_ D_  ;
UNCOMPRESS			: U_ N_ C_ O_ M_ P_ R_ E_ S_ S_  ;
UNCOMPRESSED_LENGTH		: U_ N_ C_ O_ M_ P_ R_ E_ S_ S_ E_ D_ '_' L_ E_ N_ G_ T_ H_  ;
UNDEFINED_SYM			: U_ N_ D_ E_ F_ I_ N_ E_ D_  ;
UNDO_BUFFER_SIZE_SYM		: U_ N_ D_ O_  '_' B_ U_ F_ F_ E_ R_  '_' S_ I_ Z_ E_  ;
UNDO_SYM			: U_ N_ D_ O_  ;
UNDOFILE_SYM			: U_ N_ D_ O_ F_ I_ L_ E_  ;
UNHEX				: U_ N_ H_ E_ X_  ;
UNICODE_SYM			: U_ N_ I_ C_ O_ D_ E_  ;
UNINSTALL_SYM			: U_ N_ I_ N_ S_ T_ A_ L_ L_  ;
UNION_SYM			: U_ N_ I_ O_ N_  ;
UNIQUE_SYM			: U_ N_ I_ Q_ U_ E_  ;
UNIX_TIMESTAMP			: U_ N_ I_ X_ '_' T_ I_ M_ E_ S_ T_ A_ M_ P_  ;
UNKNOWN_SYM			: U_ N_ K_ N_ O_ W_ N_  ;
UNLOCK_SYM			: U_ N_ L_ O_ C_ K_  ;
UNSIGNED_SYM			: U_ N_ S_ I_ G_ N_ E_ D_  ;
UNTIL_SYM			: U_ N_ T_ I_ L_  ;
UPDATE				: U_ P_ D_ A_ T_ E_ ;
UPGRADE_SYM			: U_ P_ G_ R_ A_ D_ E_  ;
UPPER				: (U_ P_ P_ E_ R_) | (U_ C_ A_ S_ E_)  ;
USAGE				: U_ S_ A_ G_ E_  ;
USE_FRM				: U_ S_ E_  '_' F_ R_ M_  ;
USE_SYM				: U_ S_ E_  ;
USER				: 'USER'  ;
USING_SYM			: U_ S_ I_ N_ G_ 	;
UTC_DATE			: U_ T_ C_ '_' D_ A_ T_ E_  ;
UTC_TIME			: U_ T_ C_ '_' T_ I_ M_ E_  ;
UTC_TIMESTAMP			: U_ T_ C_ '_' T_ I_ M_ E_ S_ T_ A_ M_ P_  ;
UTF16LE				: U_ T_ F_ '16' L_ E_   ;
UTF16				: U_ T_ F_ '16'  ;
UTF32				: U_ T_ F_ '32'  ;
UTF8				: U_ T_ F_ '8'  ;
UUID				: U_ U_ I_ D_  ;
VALUE_SYM			: V_ A_ L_ U_ E_  ;
VALUES				: V_ A_ L_ U_ E_ S_  ;
VAR_POP				: V_ A_ R_ '_' P_ O_ P_  ;
VAR_SAMP			: V_ A_ R_ '_' S_ A_ M_ P_  ;
VARBINARY			: V_ A_ R_ B_ I_ N_ A_ R_ Y_  ;
VARCHAR				: V_ A_ R_ C_ H_ A_ R_  ;
VARIABLES			: V_ A_ R_ I_ A_ B_ L_ E_ S_  ;
VARIANCE			: V_ A_ R_ I_ A_ N_ C_ E_  ;
VARYING				: V_ A_ R_ Y_ I_ N_ G_ ;
VERSION_SYM			: V_ E_ R_ S_ I_ O_ N_  ;
VIEW_SYM			: V_ I_ E_ W_  ;
WAIT_SYM			: W_ A_ I_ T_  ;
WARNINGS			: W_ A_ R_ N_ I_ N_ G_ S_  ;
WEEK				: W_ E_ E_ K_  ;
WEEKDAY				: W_ E_ E_ K_ D_ A_ Y_  ;
WEEKOFYEAR			: W_ E_ E_ K_ O_ F_ Y_ E_ A_ R_  ;
WEIGHT_STRING			: W_ E_ I_ G_ H_ T_ '_' S_ T_ R_ I_ N_ G_;
WHEN_SYM			: W_ H_ E_ N_ 	;
WHERE				: W_ H_ E_ R_ E_  ;
WHILE_SYM			: W_ H_ I_ L_ E_ ;
WITH				: W_ I_ T_ H_  ;
WORK_SYM			: W_ O_ R_ K_  ;
WRAPPER_SYM			: W_ R_ A_ P_ P_ E_ R_  ;
WRITE_SYM			: W_ R_ I_ T_ E_  ;
X509_SYM			: X_  '509'  ;
XA_SYM				: X_ A_  ;
XML_SYM				: X_ M_ L_  ;
XOR				: X_ O_ R_  ;
YEAR				: Y_ E_ A_ R_  ;
YEAR_MONTH			: Y_ E_ A_ R_  '_' M_ O_ N_ T_ H_  ;
YEARWEEK			: Y_ E_ A_ R_ W_ E_ E_ K_  ;
ZEROFILL			: Z_ E_ R_ O_ F_ I_ L_ L_  ;




// basic token definition ------------------------------------------------------------

DIVIDE	: (  D_ I_ V_ ) | '/' ;
MOD_SYM	: (  M_ O_ D_ ) | '%' ;
OR_SYM	: (  O_ R_ ) | '||';
AND_SYM	: (  A_ N_ D_ ) | '&&';

ARROW	: '=>' ;
EQ_SYM	: '=' | '<=>' ;
NOT_EQ	: '<>' | '!=' | '~='| '^=';
LET	: '<=' ;
GET	: '>=' ;
SET_VAR	: ':=' ;
SHIFT_LEFT	: '<<' ;
SHIFT_RIGHT	: '>>' ;
ALL_FIELDS	: '.*' ;

SEMI	: ';' ;
COLON	: ':' ;
DOT	: '.' ;
COMMA	: ',' ;
ASTERISK: '*' ;
RPAREN	: ')' ;
LPAREN	: '(' ;
RBRACK	: ']' ;
LBRACK	: '[' ;
PLUS	: '+' ;
MINUS	: '-' ;
NEGATION: '~' ;
VERTBAR	: '|' ;
BITAND	: '&' ;
POWER_OP: '^' ;
GTH	: '>' ;
LTH	: '<' ;



INTEGER_NUM		: ('0'..'9')+ ;

fragment HEX_DIGIT_FRAGMENT: ( 'a'..'f' | 'A'..'F' | '0'..'9' ) ;
HEX_DIGIT:
	(  '0x'     (HEX_DIGIT_FRAGMENT)+  )
	|
	(  'X' '\'' (HEX_DIGIT_FRAGMENT)+ '\''  ) 
;

BIT_NUM:
	(  '0b'    ('0'|'1')+  )
	|
	(  B_ '\'' ('0'|'1')+ '\''  ) 
;

REAL_NUMBER:
	(  INTEGER_NUM DOT INTEGER_NUM | INTEGER_NUM DOT | DOT INTEGER_NUM | INTEGER_NUM  )
	(  ('E'|'e') ( PLUS | MINUS )? INTEGER_NUM  )? 
;

TEXT_STRING:
	( N_ | ('_' U_ T_ F_ '8') )?
	(
		(  '\'' ( ('\\' '\\') | ('\'' '\'') | ('\\' '\'') | ~('\'') )* '\''  )
		|
		(  '\"' ( ('\\' '\\') | ('\"' '\"') | ('\\' '\"') | ~('\"') )* '\"'  ) 
	)
;

ID:	
	( 'A'..'Z' | 'a'..'z' | '_' | '$') ( 'A'..'Z' | 'a'..'z' | '_' | '$' | '0'..'9' )*
;

// http://dev.mysql.com/doc/refman/5.6/en/user-variables.html
USER_VAR:
	'@' (USER_VAR_SUBFIX1 | USER_VAR_SUBFIX2 | USER_VAR_SUBFIX3 | USER_VAR_SUBFIX4)
;
fragment USER_VAR_SUBFIX1:	(  '`' (~'`' )+ '`'  ) ;
fragment USER_VAR_SUBFIX2:	( '\'' (~'\'')+ '\'' ) ;
fragment USER_VAR_SUBFIX3:	( '\"' (~'\"')+ '\"' ) ;
fragment USER_VAR_SUBFIX4:	( 'A'..'Z' | 'a'..'z' | '_' | '$' | '0'..'9' | DOT )+ ;

WHITE_SPACE	: ( ' '|'\r'|'\t'|'\n' ) {$channel=HIDDEN;} ;

// http://dev.mysql.com/doc/refman/5.6/en/comments.html
SL_COMMENT	: ( ('--'|'#') ~('\n'|'\r')* '\r'? '\n' ) {$channel=HIDDEN;} ;
ML_COMMENT	: '/*' ( options {greedy=false;} : . )* '*/' {$channel=HIDDEN;} ;





// data type definition -----  http://dev.mysql.com/doc/refman/5.6/en/data-types.html  ---------------
/*integer_types:
	INTEGER_SYM | TINYINT | SMALLINT | MEDIUMINT | INT_SYM | BIGINT
	( LPAREN INTEGER_NUM RPAREN )?
	ZEROFILL? UNSIGNED_SYM? 
	AUTO_INCREMENT?;
fixed_point_types:
	(DECIMAL_SYM | NUMERIC_SYM)	// the same
	( LPAREN INTEGER_NUM ( COMMA INTEGER_NUM )? RPAREN )? ;
floating_point_types:
	(FLOAT_SYM | DOUBLE_SYM)
	( LPAREN INTEGER_NUM ( COMMA INTEGER_NUM )? RPAREN )? 
	AUTO_INCREMENT?;
bit_value_type:	
	BIT_SYM
	( LPAREN INTEGER_NUM RPAREN )?;
numeric_types:
	integer_types | fixed_point_types | floating_point_types | bit_value_type;

datetime_length:
	LPAREN tlen=INTEGER_NUM RPAREN {atoi((char*)($tlen.text->chars)) <= 6}?  ;
datetime_types:
	  ( DATE_SYM )
	| ( TIME_SYM (datetime_length)? )
	| ( (DATETIME | TIMESTAMP) (datetime_length)? (DEFAULT CURRENT_TIMESTAMP)? (ON UPDATE CURRENT_TIMESTAMP)? )
	| ( YEAR LPAREN ('2'|'4') RPAREN ) ;


char_varchar_types:
	( CHAR      LPAREN clen=INTEGER_NUM RPAREN {atoi((char*)($clen.text->chars)) < 256}? )
	|
	( VARCHAR   LPAREN vlen=INTEGER_NUM RPAREN {atoi((char*)($vlen.text->chars)) < 1024}? ) ;
binary_varbinary_types:
	( BINARY    LPAREN blen=INTEGER_NUM RPAREN {atoi((char*)($blen.text->chars)) < 256}? )
	|
	( VARBINARY LPAREN vlen=INTEGER_NUM RPAREN {atoi((char*)($vlen.text->chars)) < 1024}? ) ;
blob_types:
	  ( TINYBLOB   LPAREN blen=INTEGER_NUM RPAREN {atoi((char*)($blen.text->chars)) < (1<<8)}?  ) 
	| ( BLOB_SYM   LPAREN blen=INTEGER_NUM RPAREN {atoi((char*)($blen.text->chars)) < (1<<16)}? ) 
	| ( MEDIUMBLOB LPAREN blen=INTEGER_NUM RPAREN {atoi((char*)($blen.text->chars)) < (1<<24)}? ) 
	| ( LONGBLOB   LPAREN blen=INTEGER_NUM RPAREN {_atoi64((char*)($blen.text->chars)) < (1LL<<32)}? ) ;	// atoll
text_types:
	  ( TINYTEXT   LPAREN tlen=INTEGER_NUM RPAREN {atoi((char*)($tlen.text->chars)) < (1<<8)}?  ) 
	| ( TEXT_SYM   LPAREN tlen=INTEGER_NUM RPAREN {atoi((char*)($tlen.text->chars)) < (1<<16)}? ) 
	| ( MEDIUMTEXT LPAREN tlen=INTEGER_NUM RPAREN {atoi((char*)($tlen.text->chars)) < (1<<24)}? ) 
	| ( LONGTEXT   LPAREN tlen=INTEGER_NUM RPAREN {_atoi64((char*)($tlen.text->chars)) < (1LL<<32)}? ) ;	// atoll
enum_types:
	ENUM    LPAREN TEXT_STRING (COMMA TEXT_STRING)* RPAREN;		//0 <= count <= 65535
set_types:
	SET_SYM LPAREN TEXT_STRING (COMMA TEXT_STRING)* RPAREN;		//0 <= count <= 64
string_types:
	char_varchar_types
	| binary_varbinary_types
	| blob_types | text_types
	| enum_types | set_types;

datetypes_decl:
	numeric_types | datetime_types | string_types;
*/





// basic type definition -----------------------------------------------------------------------
relational_op: 
	EQ_SYM | LTH | GTH | NOT_EQ | LET | GET  ;

charset_name:
	  ARMSCII8
	| ASCII_SYM
	| BIG5
	| BINARY
	| CP1250
	| CP1251
	| CP1256
	| CP1257
	| CP850
	| CP852
	| CP866
	| CP932
	| DEC8
	| EUCJPMS
	| EUCKR
	| GB2312
	| GBK
	| GEOSTD8
	| GREEK
	| HEBREW
	| HP8
	| KEYBCS2
	| KOI8R
	| KOI8U
	| LATIN1
	| LATIN2
	| LATIN5
	| LATIN7
	| MACCE
	| MACROMAN
	| SJIS
	| SWE7
	| TIS620
	| UCS2
	| UJIS
	| UTF8;

cast_data_type:	
	BINARY (INTEGER_NUM)? 
	| CHAR (INTEGER_NUM)? 
	| DATE_SYM
	| DATETIME 
	| DECIMAL_SYM ( INTEGER_NUM (COMMA INTEGER_NUM)? )?
	| SIGNED_SYM (INTEGER_SYM)?
	| TIME_SYM
	| UNSIGNED_SYM (INTEGER_SYM)?
;

search_modifier:	
	(IN_SYM NATURAL LANGUAGE MODE_SYM)
	| (IN_SYM NATURAL LANGUAGE MODE_SYM WITH QUERY_SYM EXPANSION_SYM)
	| (IN_SYM BOOLEAN_SYM MODE_SYM)
	| (WITH QUERY_SYM EXPANSION_SYM)
;

transcoding_name:
	  LATIN1
	| UTF8
;

interval_unit:
	  SECOND
	| MINUTE
	| HOUR
	| DAY_SYM
	| WEEK
	| MONTH
	| QUARTER
	| YEAR
	| SECOND_MICROSECOND
	| MINUTE_MICROSECOND
	| MINUTE_SECOND
	| HOUR_MICROSECOND
	| HOUR_SECOND
	| HOUR_MINUTE
	| DAY_MICROSECOND
	| DAY_SECOND
	| DAY_MINUTE
	| DAY_HOUR
	| YEAR_MONTH
;

collation_names:
	LATIN1_GENERAL_CS | LATIN1_BIN
;






// basic const data definition ---------------------------------------------------------------
string_literal:		TEXT_STRING ;
number_literal:		(PLUS | MINUS)? (INTEGER_NUM | REAL_NUMBER) ;
//date_time_literal: 	;
hex_literal:		HEX_DIGIT;
boolean_literal:	TRUE_SYM | FALSE_SYM ;
bit_literal:		BIT_NUM;

// http://dev.mysql.com/doc/refman/5.6/en/literals.html
literal_value:
        ( string_literal | number_literal | hex_literal | boolean_literal | bit_literal | NULL_SYM ) ;





// function defintion ------  http://dev.mysql.com/doc/refman/5.6/en/func-op-summary-ref.html  ----------
functionList:
	  number_functions 
	| char_functions 
	| time_functions
	| other_functions
;

number_functions:
	  ABS
	| ACOS
	| ASIN
	| ATAN2
	| ATAN
	| CEIL
	| CEILING
	| CONV
	| COS
	| COT
	| CRC32
	| DEGREES
	| EXP
	| FLOOR
	| LN
	| LOG10
	| LOG2
	| LOG
	| MOD
	| PI
	| POW
	| POWER
	| RADIANS
	| RAND
	| ROUND
	| SIGN
	| SIN
	| SQRT
	| TAN
	| TRUNCATE
;	

char_functions:
	  ASCII_SYM
	| BIN
	| BIT_LENGTH
	| CHAR_LENGTH
	| CHAR
	| CONCAT_WS
	| CONCAT
	| ELT
	| EXPORT_SET
	| FIELD
	| FIND_IN_SET
	| FORMAT
	| FROM_BASE64
	| HEX
	| INSERT
	| INSTR
	| LEFT
	| LENGTH
	| LOAD_FILE
	| LOCATE
	| LOWER
	| LPAD
	| LTRIM
	| MAKE_SET
	| MID
	| OCT
	| ORD
	| QUOTE
	| REPEAT
	| REPLACE
	| REVERSE
	| RIGHT
	| RPAD
	| RTRIM
	| SOUNDEX
	| SPACE
	| STRCMP
	| SUBSTRING_INDEX
	| SUBSTRING
	| TO_BASE64
	| TRIM
	| UNHEX
	| UPPER
	| WEIGHT_STRING
;

time_functions:
	  ADDDATE
	| ADDTIME
	| CONVERT_TZ
	| CURDATE
	| CURTIME
	| DATE_ADD
	| DATE_FORMAT
	| DATE_SUB
	| DATE_SYM
	| DATEDIFF
	| DAYNAME
	| DAYOFMONTH
	| DAYOFWEEK
	| DAYOFYEAR
	| EXTRACT
	| FROM_DAYS
	| FROM_UNIXTIME
	| GET_FORMAT
	| HOUR
	| LAST_DAY 
	| MAKEDATE
	| MAKETIME 
	| MICROSECOND
	| MINUTE
	| MONTH
	| MONTHNAME
	| NOW
	| PERIOD_ADD
	| PERIOD_DIFF
	| QUARTER
	| SEC_TO_TIME
	| SECOND
	| STR_TO_DATE
	| SUBTIME
	| SYSDATE
	| TIME_FORMAT
	| TIME_TO_SEC
	| TIME_SYM
	| TIMEDIFF
	| TIMESTAMP
	| TIMESTAMPADD
	| TIMESTAMPDIFF
	| TO_DAYS
	| TO_SECONDS
	| UNIX_TIMESTAMP
	| UTC_DATE
	| UTC_TIME
	| UTC_TIMESTAMP
	| WEEK
	| WEEKDAY
	| WEEKOFYEAR
	| YEAR
	| YEARWEEK
;

other_functions:
	MAKE_SET | LOAD_FILE
	| IF | IFNULL
	| AES_ENCRYPT | AES_DECRYPT
	| DECODE | ENCODE
	| DES_DECRYPT | DES_ENCRYPT
	| ENCRYPT | MD5
	| OLD_PASSWORD | PASSWORD
	| BENCHMARK | CHARSET | COERCIBILITY | COLLATION | CONNECTION_ID
	| CURRENT_USER | DATABASE | SCHEMA | USER | SESSION_USER | SYSTEM_USER
	| VERSION_SYM
	| FOUND_ROWS | LAST_INSERT_ID | DEFAULT
	| GET_LOCK | RELEASE_LOCK | IS_FREE_LOCK | IS_USED_LOCK | MASTER_POS_WAIT
	| INET_ATON | INET_NTOA
	| NAME_CONST
	| SLEEP
	| UUID
	| VALUES
;

group_functions:
	AVG | COUNT | MAX_SYM | MIN_SYM | SUM
	| BIT_AND | BIT_OR | BIT_XOR
	| GROUP_CONCAT
	| STD | STDDEV | STDDEV_POP | STDDEV_SAMP
	| VAR_POP | VAR_SAMP | VARIANCE
;






// identifiers ---  http://dev.mysql.com/doc/refman/5.6/en/identifiers.html --------------
schema_name			: tmpName=ID {strlen((const char *)$tmpName.text->chars) <= 64}? {printf("schema name = \%s \n",(char*)($tmpName.text->chars));};
table_name			: tmpName=ID {strlen((const char *)$tmpName.text->chars) <= 64}? {printf("table name = \%s \n",(char*)($tmpName.text->chars));};
engine_name			: tmpName=ID {strlen((const char *)$tmpName.text->chars) <= 64}? {printf("engine name = \%s \n",(char*)($tmpName.text->chars));};
column_name			: tmpName=ID {strlen((const char *)$tmpName.text->chars) <= 64}? {printf("column name = \%s \n",(char*)($tmpName.text->chars));};
view_name			: tmpName=ID {strlen((const char *)$tmpName.text->chars) <= 64}? {printf("view name = \%s \n",(char*)($tmpName.text->chars));};
parser_name			: tmpName=ID {strlen((const char *)$tmpName.text->chars) <= 64}? {printf("index name = \%s \n",(char*)($tmpName.text->chars));};
index_name			: tmpName=ID {strlen((const char *)$tmpName.text->chars) <= 64}? {printf("index name = \%s \n",(char*)($tmpName.text->chars));};
partition_name			: tmpName=ID {strlen((const char *)$tmpName.text->chars) <= 64}? {printf("partition name = \%s \n",(char*)($tmpName.text->chars));};
partition_logical_name		: tmpName=ID {strlen((const char *)$tmpName.text->chars) <= 64}? {printf("partition logical name = \%s \n",(char*)($tmpName.text->chars));};
constraint_symbol_name		: tmpName=ID {strlen((const char *)$tmpName.text->chars) <= 64}? {printf("constraint symbol name = \%s \n",(char*)($tmpName.text->chars));};
foreign_key_symbol_name		: tmpName=ID {strlen((const char *)$tmpName.text->chars) <= 64}? {printf("foreign key symbol name = \%s \n",(char*)($tmpName.text->chars));};
collation_name			: tmpName=ID {strlen((const char *)$tmpName.text->chars) <= 64}? {printf("collation name = \%s \n",(char*)($tmpName.text->chars));};
event_name			: tmpName=ID {strlen((const char *)$tmpName.text->chars) <= 64}? {printf("event name = \%s \n",(char*)($tmpName.text->chars));};
user_name			: tmpName=ID {strlen((const char *)$tmpName.text->chars) <= 64}? {printf("user name = \%s \n",(char*)($tmpName.text->chars));};
function_name			: tmpName=ID {strlen((const char *)$tmpName.text->chars) <= 64}? {printf("function name = \%s \n",(char*)($tmpName.text->chars));};
procedure_name			: tmpName=ID {strlen((const char *)$tmpName.text->chars) <= 64}? {printf("procedure name = \%s \n",(char*)($tmpName.text->chars));};
server_name			: tmpName=ID {strlen((const char *)$tmpName.text->chars) <= 64}? {printf("server name = \%s \n",(char*)($tmpName.text->chars));};
wrapper_name			: tmpName=ID {strlen((const char *)$tmpName.text->chars) <= 64}? {printf("wrapper name = \%s \n",(char*)($tmpName.text->chars));};
alias				: ( AS_SYM )? tmpName=ID {strlen((const char *)$tmpName.text->chars) <= 256}? {printf("alias = \%s \n",(char*)($tmpName.text->chars));};






// expression statement -------  http://dev.mysql.com/doc/refman/5.6/en/expressions.html  -------------
expression:	exp_factor1 ( OR_SYM exp_factor1 )* ;
exp_factor1:	exp_factor2 ( XOR exp_factor2 )* ;
exp_factor2:	exp_factor3 ( AND_SYM exp_factor3 )* ;
exp_factor3:	(NOT_SYM)? exp_factor4 ;
exp_factor4:	bool_primary ( IS_SYM (NOT_SYM)? (boolean_literal|NULL_SYM) )? ;
bool_primary:
	  ( predicate relational_op predicate ) 
	| ( predicate relational_op ( ALL | ANY )? subquery )
	| ( NOT_SYM? EXISTS subquery )
	| predicate 
;
predicate:
	  ( bit_expr (NOT_SYM)? IN_SYM (subquery | expression_list) )
	| ( bit_expr (NOT_SYM)? BETWEEN bit_expr AND_SYM predicate ) 
	| ( bit_expr SOUNDS_SYM LIKE_SYM bit_expr ) 
	| ( bit_expr (NOT_SYM)? LIKE_SYM simple_expr (ESCAPE_SYM simple_expr)? )
	| ( bit_expr (NOT_SYM)? REGEXP bit_expr ) 
	| ( bit_expr )  
;
bit_expr:
	factor1 ( VERTBAR factor1 )? ;
factor1:
	factor2 ( BITAND factor2 )? ;
factor2:
	factor3 ( (SHIFT_LEFT|SHIFT_RIGHT) factor3 )? ;
factor3:
	factor4 ( (PLUS|MINUS) factor4 )? ;
factor4:
	factor5 ( (ASTERISK|DIVIDE|MOD_SYM|POWER_OP) factor5 )? ;
factor5:
	factor6 ( (PLUS|MINUS) interval_expr )? ;
factor6:
	(PLUS | MINUS | NEGATION | BINARY) simple_expr
	| simple_expr ;
factor7:
	simple_expr (COLLATE_SYM collation_names)?;
simple_expr:
	literal_value 
	| column_spec
	| function_call
	//| param_marker
	| USER_VAR
	| expression_list
	| (ROW_SYM expression_list)
	| subquery
	| EXISTS subquery
	//| {identifier expression}
	| match_against_statement
	| case_when_statement
	| interval_expr
;


function_call:
	  (  functionList ( LPAREN (expression (COMMA expression)*)? RPAREN ) ?  )
	| (  CAST_SYM LPAREN expression AS_SYM cast_data_type RPAREN  )
	| (  CONVERT_SYM LPAREN expression COMMA cast_data_type RPAREN  )
	| (  CONVERT_SYM LPAREN expression USING_SYM transcoding_name RPAREN  )
	| (  group_functions LPAREN ( ASTERISK | ALL | DISTINCT )? bit_expr RPAREN  )
;

case_when_statement:
        case_when_statement1 | case_when_statement2
;
case_when_statement1:
        CASE_SYM
        ( WHEN_SYM expression THEN_SYM bit_expr )+
        ( ELSE_SYM bit_expr )?
        END_SYM
;
case_when_statement2:
        CASE_SYM bit_expr
        ( WHEN_SYM bit_expr THEN_SYM bit_expr )+
        ( ELSE_SYM bit_expr )?
        END_SYM
;

match_against_statement:	
	MATCH (column_spec (COMMA column_spec)* ) AGAINST (expression (search_modifier)? ) 
;

column_spec:
	( ( schema_name DOT )? table_name DOT )? column_name ;

expression_list:
	LPAREN expression ( COMMA expression )* RPAREN ;

interval_expr:
	INTERVAL_SYM expression interval_unit
;






// JOIN Syntax ----------  http://dev.mysql.com/doc/refman/5.6/en/join.html  ---------------
table_references:
        table_reference ( COMMA table_reference )*
;
table_reference:
	table_factor1 | table_atom
;
table_factor1:
	table_factor2 (  (INNER_SYM | CROSS)? JOIN_SYM table_atom (join_condition)?  )?
;
table_factor2:
	table_factor3 (  STRAIGHT_JOIN table_atom (ON expression)?  )?
;
table_factor3:
	table_factor4 (  (LEFT|RIGHT) (OUTER)? JOIN_SYM table_factor4 join_condition  )?
;
table_factor4:
	table_atom (  NATURAL ( (LEFT|RIGHT) (OUTER)? )? JOIN_SYM table_atom )?
;
table_atom:
	  ( table_spec (partition_clause)? (alias)? (index_hint_list)? )
	| ( subquery alias )
	| ( LPAREN table_references RPAREN )
	| ( OJ_SYM table_reference LEFT OUTER JOIN_SYM table_reference ON expression )
;
join_condition:
	  (ON expression) | (USING_SYM column_list)
;
index_hint_list:
	index_hint (COMMA index_hint)*
;
index_options:
	(INDEX_SYM | KEY_SYM) (  FOR_SYM ((JOIN_SYM) | (ORDER_SYM BY_SYM) | (GROUP_SYM BY_SYM))  )?
;
index_hint:
	  USE_SYM    index_options LPAREN (index_list)? RPAREN
	| IGNORE_SYM index_options LPAREN index_list RPAREN
	| FORCE_SYM  index_options LPAREN index_list RPAREN
;
index_list:
	index_name (COMMA index_name)*
;
partition_clause:
	PARTITION_SYM LPAREN partition_names RPAREN
;
partition_names:	partition_name (COMMA partition_name)* ;






// SQL Statement Syntax ----  http://dev.mysql.com/doc/refman/5.6/en/sql-syntax.html ----------
root_statement:
	(SHIFT_LEFT SHIFT_RIGHT)?  
	( data_manipulation_statements | data_definition_statements /*| transactional_locking_statements | replication_statements*/ )
	(SEMI)?
;

data_manipulation_statements:
	  select_statement
	| delete_statements
	| insert_statements
	| update_statements

	| call_statement
	| do_statement
	| handler_statements
	| load_data_statement
	| load_xml_statement
	| replace_statement
;

data_definition_statements: 
	  create_database_statement
	| alter_database_statements
	| drop_database_statement
	
	| create_event_statement
	| alter_event_statement
	| drop_event_statement
	
	//| create_function_statement
	//| alter_function_statement
	//| drop_function_statement
	
	//| create_procedure_create_function_statement
	//| alter_procedure_statement
	//| drop_procedure_drop_function_statement
	
	//| create_trigger_statement
	//| drop_trigger_statement
	
	| create_server_statement
	| alter_server_statement
	| drop_server_statement
	
	| create_table_statement
	| alter_table_statement
	| drop_table_statement
	
	| create_view_statement
	| alter_view_statement
	| rename_table_statement
	| drop_view_statement
	| truncate_table_statement
	
	| create_index_statement
	| drop_index_statement
;

/*transactional_locking_statements:
	  start_transaction_statement
	| comment_statement
	| rollback_statement

	| savepoint_statement
	| rollback_to_savepoint_statement
	| release_savepoint_statement

	| lock_table_statement
	| unlock_table_statement

	| set_transaction_statement
	
	| xa_transaction_statement
;

replication_statements:	
	  controlling_master_servers_statements
	| controlling_slave_servers_statements
;
*/







// select ------  http://dev.mysql.com/doc/refman/5.6/en/select.html  -------------------------------
select_statement:
        select_expression ( (UNION_SYM (ALL)?) select_expression )* 
;

select_expression:
	SELECT 
	
	( ALL | DISTINCT | DISTINCTROW )? 
	(HIGH_PRIORITY)?
	(STRAIGHT_JOIN)?
	(SQL_SMALL_RESULT)? (SQL_BIG_RESULT)? (SQL_BUFFER_RESULT)?
	(SQL_CACHE_SYM | SQL_NO_CACHE_SYM)? (SQL_CALC_FOUND_ROWS)?

	select_list
	
	( 
		FROM table_references 
		( partition_clause )?
		( where_clause )? 
		( groupby_clause )?
		( having_clause )?
	) ?
	
	( orderby_clause )?
	( limit_clause )?
	( ( FOR_SYM UPDATE) | (LOCK IN_SYM SHARE_SYM MODE_SYM) )? 
;

where_clause:
	WHERE expression
;

groupby_clause:
	GROUP_SYM BY_SYM groupby_item (COMMA groupby_item)* (WITH ROLLUP_SYM)?
;
groupby_item:	column_spec | INTEGER_NUM | bit_expr ;

having_clause:
	HAVING expression
;

orderby_clause:
	ORDER_SYM BY_SYM orderby_item (COMMA orderby_item)*
;
orderby_item:	groupby_item (ASC | DESC)? ;

limit_clause:
	LIMIT ((offset COMMA)? row_count) | (row_count OFFSET_SYM offset)
;
offset:		INTEGER_NUM ;
row_count:	INTEGER_NUM ;

select_list:
	( ( displayed_column ( COMMA displayed_column )*)
	| ASTERISK ) 
;

column_list:
	LPAREN column_spec (COMMA column_spec)* RPAREN
;

subquery:
	LPAREN select_statement RPAREN
;

table_spec:
	( schema_name DOT )? table_name
;

displayed_column :
	( table_spec DOT ASTERISK )
	|
	( column_spec (alias)? )
	| 
	( bit_expr (alias)? )
;







// delete ------  http://dev.mysql.com/doc/refman/5.6/en/delete.html  ------------------------
delete_statements:
	DELETE_SYM (LOW_PRIORITY)? (QUICK)? (IGNORE_SYM)?
	( delete_single_table_statement | delete_multiple_table_statement1 | delete_multiple_table_statement2 )
;
delete_single_table_statement:
	FROM table_spec
	(partition_clause)?
	(where_clause)?
	(orderby_clause)?
	(limit_clause)?
;
delete_multiple_table_statement1:
	table_spec (ALL_FIELDS)? (COMMA table_spec (ALL_FIELDS)?)*
	FROM table_references
	(where_clause)?
;
delete_multiple_table_statement2:
	FROM table_spec (ALL_FIELDS)? (COMMA table_spec (ALL_FIELDS)?)*
	USING_SYM table_references
	(where_clause)?
;





// insert ---------  http://dev.mysql.com/doc/refman/5.6/en/insert.html  -------------------------
insert_statements :
	insert_statement1 | insert_statement2 | insert_statement3
;

insert_header:
	INSERT (LOW_PRIORITY | HIGH_PRIORITY)? (IGNORE_SYM)?
	(INTO)? table_spec 
	(partition_clause)?
;

insert_subfix:
	ON DUPLICATE_SYM KEY_SYM UPDATE column_spec EQ_SYM expression (COMMA column_spec EQ_SYM expression)*
;

insert_statement1:
	insert_header
	(column_list)? 
	value_list_clause
	( insert_subfix )?
;
value_list_clause:	(VALUES | VALUE_SYM) column_value_list (COMMA column_value_list)*;
column_value_list:	LPAREN (bit_expr|DEFAULT) (COMMA (bit_expr|DEFAULT) )* RPAREN ;

insert_statement2:
	insert_header
	set_columns_cluase
	( insert_subfix )?
;
set_columns_cluase:	SET_SYM set_column_cluase ( COMMA set_column_cluase )*;
set_column_cluase:	column_spec EQ_SYM (expression|DEFAULT) ;

insert_statement3:
	insert_header
	(column_list)? 
	select_expression
	( insert_subfix )?
;







// update --------  http://dev.mysql.com/doc/refman/5.6/en/update.html  ------------------------
update_statements :
	single_table_update_statement | multiple_table_update_statement
;

single_table_update_statement: 
UPDATE (LOW_PRIORITY)? (IGNORE_SYM)? table_reference
	set_columns_cluase
	(where_clause)?
	(orderby_clause)?
	(limit_clause)?
;

multiple_table_update_statement: 
	UPDATE (LOW_PRIORITY)? (IGNORE_SYM)? table_references
	set_columns_cluase
	(where_clause)?
;






// call -----------  http://dev.mysql.com/doc/refman/5.6/en/call.html  -------------------------
call_statement:
	CALL_SYM procedure_name (LPAREN ( bit_expr (COMMA bit_expr)* )? RPAREN)?
;






// do --------------  http://dev.mysql.com/doc/refman/5.6/en/do.html  ----------------------------
do_statement:
	DO_SYM root_statement (COMMA root_statement)*
;






// handler ------------  http://dev.mysql.com/doc/refman/5.6/en/handler.html  ----------------------
handler_statements:
	HANDLER_SYM table_name
	(open_handler_statement | handler_statement1 | handler_statement2 | handler_statement3 | close_handler_statement)
;

open_handler_statement:
	OPEN_SYM (alias)?
;

handler_statement1:
	READ_SYM index_name relational_op LPAREN bit_expr (COMMA bit_expr)* RPAREN
	(where_clause)? (limit_clause)?
;

handler_statement2:
	READ_SYM index_name (FIRST_SYM | NEXT_SYM | PREV_SYM | LAST_SYM)
	(where_clause)? (limit_clause)?
;

handler_statement3:
	READ_SYM (FIRST_SYM | NEXT_SYM)
	(where_clause)? (limit_clause)?
;

close_handler_statement:
	CLOSE_SYM
;







// load data ------------  http://dev.mysql.com/doc/refman/5.6/en/load-data.html  ---------------------
load_data_statement:
	LOAD DATA_SYM (LOW_PRIORITY | CONCURRENT)? (LOCAL_SYM)? INFILE TEXT_STRING
	(REPLACE | IGNORE_SYM)?
	INTO TABLE table_spec
	(partition_clause)?
	(CHARACTER_SYM SET_SYM charset_name)?
	(
		(FIELDS_SYM | COLUMNS_SYM)
		(TERMINATED BY_SYM TEXT_STRING)?
		((OPTIONALLY)? ENCLOSED BY_SYM TEXT_STRING)?
		(ESCAPED BY_SYM TEXT_STRING)?
	)?
	(
		LINES
		(STARTING BY_SYM TEXT_STRING)?
		(TERMINATED BY_SYM TEXT_STRING)?
	)?
	(IGNORE_SYM INTEGER_NUM (LINES | ROWS_SYM))?
	(LPAREN (column_spec|USER_VAR) (COMMA (column_spec|USER_VAR))* RPAREN)?
	(set_columns_cluase)?
;






// load xml ---------------  http://dev.mysql.com/doc/refman/5.6/en/load-xml.html  ----------------------
load_xml_statement:
	LOAD XML_SYM (LOW_PRIORITY | CONCURRENT)? (LOCAL_SYM)? INFILE TEXT_STRING
	(REPLACE | IGNORE_SYM)?
	INTO TABLE table_spec
	(partition_clause)?
	(CHARACTER_SYM SET_SYM charset_name)?
	(ROWS_SYM IDENTIFIED_SYM BY_SYM TEXT_STRING)?
	(IGNORE_SYM INTEGER_NUM (LINES | ROWS_SYM))?
	(LPAREN (column_spec|USER_VAR) (COMMA (column_spec|USER_VAR))* RPAREN)?
	(set_columns_cluase)?
;






// replace -------------------  http://dev.mysql.com/doc/refman/5.6/en/replace.html  ---------------------
replace_statement:
	replace_statement_header
	( replace_statement1 | replace_statement2 | replace_statement3 )
;

replace_statement_header:
	REPLACE (LOW_PRIORITY | DELAYED_SYM)?
	(INTO)? table_name
	(partition_clause)?
;

replace_statement1:
	(column_list)?
	value_list_clause
;

replace_statement2:
	set_columns_cluase
;

replace_statement3:
	(column_list)?
	select_statement
;







// http://dev.mysql.com/doc/refman/5.6/en/create-database.html
create_database_statement:
	CREATE (DATABASE | SCHEMA) (IF NOT_SYM EXISTS)? schema_name
	( create_specification (COMMA create_specification)* )*
;
create_specification:
	(DEFAULT)? 
	(
		(  CHARACTER_SYM SET_SYM (EQ_SYM)? charset_name  )
		|
		(  COLLATE_SYM (EQ_SYM)? collation_name  )
	)
;


// http://dev.mysql.com/doc/refman/5.6/en/alter-database.html
alter_database_statements:
	alter_database_statement1 | alter_database_statement2
;
alter_database_statement1:
	ALTER (DATABASE | SCHEMA) (schema_name)?
	alter_database_specification
;
alter_database_statement2:
	ALTER (DATABASE | SCHEMA) schema_name
	UPGRADE_SYM DATA_SYM DIRECTORY_SYM NAME_SYM
;
alter_database_specification:
	(DEFAULT)? CHARACTER_SYM SET_SYM (EQ_SYM)? charset_name
	| 
	(DEFAULT)? COLLATE_SYM (EQ_SYM)? collation_names

;


// http://dev.mysql.com/doc/refman/5.6/en/drop-database.html
drop_database_statement:
	DROP (DATABASE | SCHEMA) (IF EXISTS)? schema_name
;






// http://dev.mysql.com/doc/refman/5.6/en/create-event.html
create_event_statement:
	CREATE
	(DEFINER EQ_SYM ( user_name | CURRENT_USER ))?
	EVENT_SYM
	(IF NOT_SYM EXISTS)?
	event_name
	ON SCHEDULE_SYM schedule_definition
	(ON COMPLETION_SYM (NOT_SYM)? PRESERVE_SYM)?
	( ENABLE_SYM | DISABLE_SYM | (DISABLE_SYM ON SLAVE) )?
	(COMMENT_SYM TEXT_STRING)?
	do_statement
;
schedule_definition:
	( AT_SYM timestamp (PLUS INTERVAL_SYM interval)* )
	| 
	( EVERY_SYM interval )
	( STARTS_SYM timestamp (PLUS INTERVAL_SYM interval)* )?
	( ENDS_SYM timestamp (PLUS INTERVAL_SYM interval)* )?
;
interval:
	INTEGER_NUM (YEAR | QUARTER | MONTH | DAY_SYM | HOUR | MINUTE |
	          WEEK | SECOND | YEAR_MONTH | DAY_HOUR | DAY_MINUTE |
	          DAY_SECOND | HOUR_MINUTE | HOUR_SECOND | MINUTE_SECOND)

;
timestamp:
	CURRENT_TIMESTAMP 
	//| timestamp_literal 
	//...
;


// http://dev.mysql.com/doc/refman/5.6/en/alter-event.html
alter_event_statement:
	ALTER
	(DEFINER EQ_SYM ( user_name | CURRENT_USER ))?
	EVENT_SYM event_name
	(ON SCHEDULE_SYM schedule_definition)?
	(ON COMPLETION_SYM (NOT_SYM)? PRESERVE_SYM)?
	(RENAME TO_SYM event_name)?
	( ENABLE_SYM | DISABLE_SYM | (DISABLE_SYM ON SLAVE) )?
	(COMMENT_SYM TEXT_STRING)?
	(do_statement)?
;


// http://dev.mysql.com/doc/refman/5.6/en/drop-event.html
drop_event_statement:
	DROP EVENT_SYM (IF EXISTS)? event_name
;





/*
// http://dev.mysql.com/doc/refman/5.6/en/create-function.html
create_function_statement:
;


// http://dev.mysql.com/doc/refman/5.6/en/alter-function.html
alter_function_statement:
	ALTER FUNCTION_SYM function_name (characteristic)*
;
characteristic:
	  ( COMMENT_SYM TEXT_STRING )
	| ( LANGUAGE SQL_SYM )
	| ( (CONTAINS_SYM SQL_SYM) | (NO_SYM SQL_SYM) | (READS_SYM SQL_SYM DATA_SYM) | (MODIFIES_SYM SQL_SYM DATA_SYM) )
	| ( SQL_SYM SECURITY_SYM (DEFINER | INVOKER_SYM) )
;


// http://dev.mysql.com/doc/refman/5.6/en/drop-function.html
drop_function_statement:
;
*/






// http://dev.mysql.com/doc/refman/5.6/en/create-index.html
create_index_statement:
	CREATE (UNIQUE_SYM|FULLTEXT_SYM|SPATIAL_SYM)? INDEX_SYM index_name
	(index_type)?
	ON table_name LPAREN index_column_name (COMMA index_column_name)* RPAREN
	(algorithm_option | lock_option)*
;
algorithm_option:
	ALGORITHM_SYM (EQ_SYM)? (DEFAULT|INPLACE_SYM|COPY_SYM)
;
lock_option:
	LOCK (EQ_SYM)? (DEFAULT|NONE_SYM|SHARED_SYM|EXCLUSIVE_SYM)
;


// http://dev.mysql.com/doc/refman/5.6/en/drop-index.html
drop_index_statement:
	DROP INDEX_SYM index_name ON table_name
	(algorithm_option | lock_option)*
;







/*
// http://dev.mysql.com/doc/refman/5.6/en/create-procedure.html
create_procedure_create_function_statement:
;


// http://dev.mysql.com/doc/refman/5.6/en/alter-procedure.html
alter_procedure_statement:
	ALTER PROCEDURE procedure_name (characteristic)*
;


// http://dev.mysql.com/doc/refman/5.6/en/drop-procedure.html
drop_procedure_drop_function_statement:
;
*/






// http://dev.mysql.com/doc/refman/5.6/en/create-server.html
create_server_statement:
	CREATE SERVER_SYM server_name
	FOREIGN DATA_SYM WRAPPER_SYM wrapper_name
	OPTIONS_SYM LPAREN create_server_option (COMMA create_server_option)* RPAREN
;
create_server_option:
	| ( HOST_SYM string_literal )
	| ( DATABASE string_literal )
	| ( USER string_literal )
	| ( PASSWORD string_literal )
	| ( SOCKET_SYM string_literal )
	| ( OWNER_SYM string_literal )
	| ( PORT_SYM number_literal )
;


// http://dev.mysql.com/doc/refman/5.6/en/alter-server.html
alter_server_statement:
	ALTER SERVER_SYM server_name
	OPTIONS_SYM LPAREN alter_server_option (COMMA alter_server_option)* RPAREN
;
alter_server_option:
	(USER) (ID|TEXT_STRING)
;


// http://dev.mysql.com/doc/refman/5.6/en/drop-server.html
drop_server_statement:
	DROP SERVER_SYM (IF EXISTS)? server_name
;






// http://dev.mysql.com/doc/refman/5.6/en/create-table.html
create_table_statement:
	create_table_statement1 | create_table_statement2 | create_table_statement3
;

create_table_statement1:	
	CREATE (TEMPORARY)? TABLE (IF NOT_SYM EXISTS)? table_name
	LPAREN create_definition (COMMA create_definition)* RPAREN
	(table_options)?
	(partition_options)?
	(select_statement)?
;

create_table_statement2:
	CREATE (TEMPORARY)? TABLE (IF NOT_SYM EXISTS)? table_name
	(table_options)?
	(partition_options)?
	select_statement
;

create_table_statement3:
	CREATE (TEMPORARY)? TABLE (IF NOT_SYM EXISTS)? table_name
	( (LIKE_SYM table_name) | (LPAREN LIKE_SYM table_name RPAREN) )
;

create_definition:
	  (  column_name column_definition  )
	| (  (CONSTRAINT (constraint_symbol_name)?)? PRIMARY_SYM KEY_SYM (index_type)? LPAREN index_column_name (COMMA index_column_name)* RPAREN (index_option)*  )
	| (  (INDEX_SYM|KEY_SYM) (index_name)? (index_type)? LPAREN index_column_name (COMMA index_column_name)* RPAREN (index_option)*  )
	| (  (CONSTRAINT (constraint_symbol_name)?)? UNIQUE_SYM (INDEX_SYM|KEY_SYM)? (index_name)? (index_type)? LPAREN index_column_name (COMMA index_column_name)* RPAREN (index_option)*  )
	| (  (FULLTEXT_SYM|SPATIAL_SYM) (INDEX_SYM|KEY_SYM)? (index_name)? LPAREN index_column_name (COMMA index_column_name)* RPAREN (index_option)*  )
	| (  (CONSTRAINT (constraint_symbol_name)?)? FOREIGN KEY_SYM (index_name)? LPAREN index_column_name (COMMA index_column_name)* RPAREN reference_definition  )
	| (  CHECK_SYM LPAREN expression RPAREN  )
;

column_definition:
	column_data_type_header
	(AUTO_INCREMENT)? ( (UNIQUE_SYM (KEY_SYM)?) | (PRIMARY_SYM (KEY_SYM)?) )?
	(COMMENT_SYM TEXT_STRING)?
	(COLUMN_FORMAT (FIXED_SYM|DYNAMIC_SYM|DEFAULT))?
	(reference_definition)?
;

null_or_notnull:
	(NOT_SYM NULL_SYM) | NULL_SYM
;

column_data_type_header:
	  (  BIT_SYM(LPAREN length RPAREN)? (null_or_notnull)? (DEFAULT bit_literal)?  )
	| (  TINYINT(LPAREN length RPAREN)? (UNSIGNED_SYM)? (ZEROFILL)? (null_or_notnull)? (DEFAULT number_literal)?  )
	| (  SMALLINT(LPAREN length RPAREN)? (UNSIGNED_SYM)? (ZEROFILL)? (null_or_notnull)? (DEFAULT number_literal)?  )
	| (  MEDIUMINT(LPAREN length RPAREN)? (UNSIGNED_SYM)? (ZEROFILL)? (null_or_notnull)? (DEFAULT number_literal)?  )
	| (  INT_SYM(LPAREN length RPAREN)? (UNSIGNED_SYM)? (ZEROFILL)? (null_or_notnull)? (DEFAULT number_literal)?  )
	| (  INTEGER_SYM(LPAREN length RPAREN)? (UNSIGNED_SYM)? (ZEROFILL)? (null_or_notnull)? (DEFAULT number_literal)?  )
	| (  BIGINT(LPAREN length RPAREN)? (UNSIGNED_SYM)? (ZEROFILL)? (null_or_notnull)? (DEFAULT number_literal)?  )
	| (  REAL(LPAREN length COMMA number_literal RPAREN)? (UNSIGNED_SYM)? (ZEROFILL)? (null_or_notnull)? (DEFAULT number_literal)?  )
	| (  DOUBLE_SYM(LPAREN length COMMA number_literal RPAREN)? (UNSIGNED_SYM)? (ZEROFILL)? (null_or_notnull)? (DEFAULT number_literal)?  )
	| (  FLOAT_SYM(LPAREN length COMMA number_literal RPAREN)? (UNSIGNED_SYM)? (ZEROFILL)? (null_or_notnull)? (DEFAULT number_literal)?  )
	| (  DECIMAL_SYM(LPAREN length( COMMA number_literal)? RPAREN)? (UNSIGNED_SYM)? (ZEROFILL)? (null_or_notnull)? (DEFAULT number_literal)?  )
	| (  NUMERIC_SYM(LPAREN length( COMMA number_literal)? RPAREN)? (UNSIGNED_SYM)? (ZEROFILL)? (null_or_notnull)? (DEFAULT number_literal)?  )
	| (  DATE_SYM (null_or_notnull)? (DEFAULT TEXT_STRING)?  )
	| (  TIME_SYM (null_or_notnull)? (DEFAULT TEXT_STRING)?  )
	| (  TIMESTAMP (null_or_notnull)? (DEFAULT (CURRENT_TIMESTAMP|TEXT_STRING))?  )
	| (  DATETIME (null_or_notnull)? (DEFAULT (CURRENT_TIMESTAMP|TEXT_STRING))?  )
	| (  YEAR (null_or_notnull)? (DEFAULT INTEGER_NUM)?  )
	| (  CHAR   (LPAREN length RPAREN)? (CHARACTER_SYM SET_SYM charset_name)? (COLLATE_SYM collation_name)? (null_or_notnull)? (DEFAULT TEXT_STRING)?  )
	| (  VARCHAR LPAREN length RPAREN   (CHARACTER_SYM SET_SYM charset_name)? (COLLATE_SYM collation_name)? (null_or_notnull)? (DEFAULT TEXT_STRING)?  )
	| (  BINARY   (LPAREN length RPAREN)? (null_or_notnull)? (DEFAULT TEXT_STRING)?  )
	| (  VARBINARY LPAREN length RPAREN (null_or_notnull)? (DEFAULT TEXT_STRING)?  )
	| (  TINYBLOB (null_or_notnull)?  )
	| (  BLOB_SYM (null_or_notnull)?  )
	| (  MEDIUMBLOB (null_or_notnull)?  )
	| (  LONGBLOB (null_or_notnull)?  )
	| (  TINYTEXT   (BINARY)? (CHARACTER_SYM SET_SYM charset_name)? (COLLATE_SYM collation_name)? (null_or_notnull)?  )
	| (  TEXT_SYM   (BINARY)? (CHARACTER_SYM SET_SYM charset_name)? (COLLATE_SYM collation_name)? (null_or_notnull)?  )
	| (  MEDIUMTEXT (BINARY)? (CHARACTER_SYM SET_SYM charset_name)? (COLLATE_SYM collation_name)? (null_or_notnull)?  )
	| (  LONGTEXT   (BINARY)? (CHARACTER_SYM SET_SYM charset_name)? (COLLATE_SYM collation_name)? (null_or_notnull)?  )
	| (  ENUM    LPAREN TEXT_STRING (COMMA TEXT_STRING)* RPAREN (CHARACTER_SYM SET_SYM charset_name)? (COLLATE_SYM collation_name)? (null_or_notnull)? (DEFAULT TEXT_STRING)?  )
	| (  SET_SYM LPAREN TEXT_STRING (COMMA TEXT_STRING)* RPAREN (CHARACTER_SYM SET_SYM charset_name)? (COLLATE_SYM collation_name)? (null_or_notnull)? (DEFAULT TEXT_STRING)?  )
	//| (  spatial_type (null_or_notnull)? (DEFAULT default_value)?  )
;

index_column_name:
	column_name (LPAREN INTEGER_NUM RPAREN)? (ASC | DESC)?
;

reference_definition:
	REFERENCES table_name LPAREN index_column_name (COMMA index_column_name)* RPAREN
	( (MATCH FULL) | (MATCH PARTIAL) | (MATCH SIMPLE_SYM) )?
	(ON DELETE_SYM reference_option)?
	(ON UPDATE reference_option)?
;
reference_option:
	(RESTRICT) | (CASCADE) | (SET_SYM NULL_SYM) | (NO_SYM ACTION)
;

table_options:
	table_option (( COMMA )? table_option)*
;
table_option:
	  (  ENGINE_SYM (EQ_SYM)? engine_name  )
	| (  AUTO_INCREMENT (EQ_SYM)? INTEGER_NUM  )
	| (  AVG_ROW_LENGTH (EQ_SYM)? INTEGER_NUM  )
	| (  (DEFAULT)? CHARACTER_SYM SET_SYM (EQ_SYM)? charset_name  )
	| (  CHECKSUM_SYM (EQ_SYM)? INTEGER_NUM  )
	| (  (DEFAULT)? COLLATE_SYM (EQ_SYM)? collation_name  )
	| (  COMMENT_SYM (EQ_SYM)? TEXT_STRING  )
	| (  CONNECTION_SYM (EQ_SYM)? TEXT_STRING  )
	| (  DATA_SYM DIRECTORY_SYM (EQ_SYM)? TEXT_STRING  )
	| (  DELAY_KEY_WRITE_SYM (EQ_SYM)? INTEGER_NUM  )
	| (  INDEX_SYM DIRECTORY_SYM (EQ_SYM)? TEXT_STRING  )
	| (  INSERT_METHOD (EQ_SYM)? ( NO_SYM | FIRST_SYM | LAST_SYM )  )
	| (  KEY_BLOCK_SIZE (EQ_SYM)? INTEGER_NUM  )
	| (  MAX_ROWS (EQ_SYM)? INTEGER_NUM  )
	| (  MIN_ROWS (EQ_SYM)? INTEGER_NUM  )
	| (  PACK_KEYS_SYM (EQ_SYM)? (INTEGER_NUM | DEFAULT)  )
	| (  PASSWORD (EQ_SYM)? TEXT_STRING  )
	| (  ROW_FORMAT_SYM (EQ_SYM)? (DEFAULT|DYNAMIC_SYM|FIXED_SYM|COMPRESSED_SYM|REDUNDANT_SYM|COMPACT_SYM)  )
	| (  STATS_AUTO_RECALC (EQ_SYM)? (DEFAULT | INTEGER_NUM)  )
	| (  STATS_PERSISTENT (EQ_SYM)? (DEFAULT | INTEGER_NUM)  )
	| (  UNION_SYM (EQ_SYM)? LPAREN table_name( COMMA table_name)* RPAREN  )
;

partition_options:
	PARTITION_SYM BY_SYM
	( 
		  ( (LINEAR_SYM)? HASH_SYM LPAREN expression RPAREN )
		| ( (LINEAR_SYM)? KEY_SYM LPAREN column_list RPAREN )
		| ( RANGE_SYM(LPAREN expression RPAREN | COLUMNS_SYM LPAREN column_list RPAREN) )
		| ( LIST_SYM(LPAREN expression RPAREN | COLUMNS_SYM LPAREN column_list RPAREN) )
	)
	
	(PARTITIONS_SYM INTEGER_NUM)?
	
	(
		SUBPARTITION_SYM BY_SYM
		( ( (LINEAR_SYM)? HASH_SYM LPAREN expression RPAREN ) | ( (LINEAR_SYM)? KEY_SYM LPAREN column_list RPAREN ) )
		(SUBPARTITIONS_SYM INTEGER_NUM)?
	)?
	
	(LPAREN partition_definition ( COMMA  partition_definition)* RPAREN)?
;

partition_definition:
	PARTITION_SYM partition_name
	
	(
		VALUES 
		(
			(LESS_SYM THAN_SYM ( (LPAREN expression_list RPAREN) | MAXVALUE_SYM ))
			| 
			(IN_SYM LPAREN expression_list RPAREN)
		)
	)?
	
	((STORAGE_SYM)? ENGINE_SYM (EQ_SYM)? engine_name)?
	(COMMENT_SYM (EQ_SYM)? TEXT_STRING )?
	(DATA_SYM DIRECTORY_SYM (EQ_SYM)? TEXT_STRING)?
	(INDEX_SYM DIRECTORY_SYM (EQ_SYM)? TEXT_STRING)?
	(MAX_ROWS (EQ_SYM)? INTEGER_NUM)?
	(MIN_ROWS (EQ_SYM)? INTEGER_NUM)?
	(LPAREN subpartition_definition (COMMA  subpartition_definition)* RPAREN)?
;

subpartition_definition:
	SUBPARTITION_SYM partition_logical_name
	((STORAGE_SYM)? ENGINE_SYM (EQ_SYM)? engine_name)?
	(COMMENT_SYM (EQ_SYM)? TEXT_STRING )?
	(DATA_SYM DIRECTORY_SYM (EQ_SYM)? TEXT_STRING)?
	(INDEX_SYM DIRECTORY_SYM (EQ_SYM)? TEXT_STRING)?
	(MAX_ROWS (EQ_SYM)? INTEGER_NUM)?
	(MIN_ROWS (EQ_SYM)? INTEGER_NUM)?
;

length	:	INTEGER_NUM;


// http://dev.mysql.com/doc/refman/5.6/en/alter-table.html
alter_table_statement:
	ALTER (IGNORE_SYM)? TABLE table_name
	( alter_table_specification (COMMA alter_table_specification)* )?
	( partition_options )?
;
alter_table_specification:
	  table_options
	| ( ADD_SYM (COLUMN_SYM)? column_name column_definition ( (FIRST_SYM|AFTER_SYM) column_name )? )
	| ( ADD_SYM (COLUMN_SYM)? LPAREN column_definitions RPAREN )
	| ( ADD_SYM (INDEX_SYM|KEY_SYM) (index_name)? (index_type)? LPAREN index_column_names RPAREN (index_option)* )
	| ( ADD_SYM (CONSTRAINT (constraint_symbol_name)?)? PRIMARY_SYM KEY_SYM (index_type)? LPAREN index_column_names RPAREN (index_option)* )
	| 
		( 
		ADD_SYM (CONSTRAINT (constraint_symbol_name)?)? UNIQUE_SYM (INDEX_SYM|KEY_SYM)? (index_name)? 
		(index_type)? LPAREN index_column_name (COMMA index_column_name)* RPAREN (index_option)*
		)
	| ( ADD_SYM FULLTEXT_SYM (INDEX_SYM|KEY_SYM)? (index_name)? LPAREN index_column_names RPAREN (index_option)* )
	| ( ADD_SYM SPATIAL_SYM (INDEX_SYM|KEY_SYM)? (index_name)? LPAREN index_column_names RPAREN (index_option)* )
	| ( ADD_SYM (CONSTRAINT (constraint_symbol_name)?)? FOREIGN KEY_SYM (index_name)? LPAREN index_column_names RPAREN reference_definition )
	| ( ALGORITHM_SYM (EQ_SYM)? (DEFAULT|INPLACE_SYM|COPY_SYM) )
	| ( ALTER (COLUMN_SYM)? column_name ((SET_SYM DEFAULT literal_value) | (DROP DEFAULT)) )
	| ( CHANGE (COLUMN_SYM)? column_name column_name column_definition (FIRST_SYM|AFTER_SYM column_name)? )
	| ( LOCK (EQ_SYM)? (DEFAULT|NONE_SYM|SHARED_SYM|EXCLUSIVE_SYM) )
	| ( MODIFY_SYM (COLUMN_SYM)? column_name column_definition (FIRST_SYM | AFTER_SYM column_name)? )
	| ( DROP (COLUMN_SYM)? column_name )
	| ( DROP PRIMARY_SYM KEY_SYM )
	| ( DROP (INDEX_SYM|KEY_SYM) index_name )
	| ( DROP FOREIGN KEY_SYM foreign_key_symbol_name )
	| ( DISABLE_SYM KEYS )
	| ( ENABLE_SYM KEYS )
	| ( RENAME (TO_SYM|AS_SYM)? table_name )
	| ( ORDER_SYM BY_SYM column_name (COMMA column_name)* )
	| ( CONVERT_SYM TO_SYM CHARACTER_SYM SET_SYM charset_name (COLLATE_SYM collation_name)? )
	| ( (DEFAULT)? CHARACTER_SYM SET_SYM (EQ_SYM)? charset_name (COLLATE_SYM (EQ_SYM)? collation_name)? )
	| ( DISCARD TABLESPACE )
	| ( IMPORT TABLESPACE )
	| ( FORCE_SYM )
	| ( ADD_SYM PARTITION_SYM LPAREN partition_definition RPAREN )
	| ( DROP PARTITION_SYM partition_names )
	| ( TRUNCATE PARTITION_SYM (partition_names | ALL) )
	| ( COALESCE PARTITION_SYM INTEGER_NUM )
	| ( REORGANIZE_SYM PARTITION_SYM partition_names INTO LPAREN partition_definition (COMMA partition_definition)* RPAREN )
	| ( EXCHANGE_SYM PARTITION_SYM partition_name WITH TABLE table_name )
	| ( ANALYZE_SYM PARTITION_SYM (partition_names | ALL) )
	| ( CHECK_SYM PARTITION_SYM (partition_names | ALL) )
	| ( OPTIMIZE PARTITION_SYM (partition_names | ALL) )
	| ( REBUILD_SYM PARTITION_SYM (partition_names | ALL) )
	| ( REPAIR PARTITION_SYM (partition_names | ALL) )
	| ( REMOVE_SYM PARTITIONING_SYM )
;
index_column_names:
	index_column_name (COMMA index_column_name)*;
index_type:
	USING_SYM (BTREE_SYM | HASH_SYM)
;
index_option:
	  ( KEY_BLOCK_SIZE (EQ_SYM)? INTEGER_NUM )
	| index_type
	| ( WITH PARSER_SYM parser_name )
	| ( COMMENT_SYM TEXT_STRING )
;
column_definitions:
	column_name column_definition (COMMA column_name column_definition)*
;


// http://dev.mysql.com/doc/refman/5.6/en/rename-table.html
rename_table_statement:
	RENAME TABLE 
	table_name TO_SYM table_name
	(COMMA table_name TO_SYM table_name)*
;


// http://dev.mysql.com/doc/refman/5.6/en/drop-table.html
drop_table_statement:
	DROP (TEMPORARY)? TABLE (IF EXISTS)?
	table_name (COMMA table_name)*
	(RESTRICT | CASCADE)?
;


// http://dev.mysql.com/doc/refman/5.6/en/truncate-table.html
truncate_table_statement:
	TRUNCATE (TABLE)? table_name
;





/*
// http://dev.mysql.com/doc/refman/5.6/en/create-trigger.html
create_trigger_statement:
	CREATE
	(DEFINER EQ_SYM (user_name | CURRENT_USER))?
	// ...
;


// http://dev.mysql.com/doc/refman/5.6/en/drop-trigger.html
drop_trigger_statement:
;
*/




// http://dev.mysql.com/doc/refman/5.6/en/create-view.html
create_view_statement:
	CREATE (OR_SYM REPLACE)?
	create_view_body
;
create_view_body:
	(ALGORITHM_SYM EQ_SYM (UNDEFINED_SYM | MERGE_SYM | TEMPTABLE_SYM))?
	(DEFINER EQ_SYM (user_name | CURRENT_USER) )?
	(SQL_SYM SECURITY_SYM ( DEFINER | INVOKER_SYM ))?
	VIEW_SYM view_name (LPAREN column_list RPAREN)?
	AS_SYM select_statement
	(WITH (CASCADED | LOCAL_SYM)? CHECK_SYM OPTION)?
;


// http://dev.mysql.com/doc/refman/5.6/en/alter-view.html
alter_view_statement:
	ALTER
	create_view_body
;


// http://dev.mysql.com/doc/refman/5.6/en/drop-view.html
drop_view_statement:
	DROP VIEW_SYM (IF EXISTS)?
	view_name (COMMA view_name)*
	(RESTRICT | CASCADE)?
;


