; TODO: add support for CAS

(context 'sdb)

(if (= ostype "OSX")
	(constant 'SDBLIB "/usr/lib/libsdb.dylib") ; osx
	(constant 'SDBLIB "/usr/lib/libsdb.so") ; linux
)

(import SDBLIB "sdb_new")
(import SDBLIB "sdb_set")
(import SDBLIB "sdb_inc")
(import SDBLIB "sdb_dec")
(import SDBLIB "sdb_hash")
(import SDBLIB "sdb_get")
(import SDBLIB "sdb_sync")
(import SDBLIB "sdb_free")
(import SDBLIB "sdb_query")
(import SDBLIB "sdb_querys")
(import SDBLIB "sdb_alength")
(import SDBLIB "sdb_adel")
(import SDBLIB "sdb_aget")
(import SDBLIB "sdb_aset")
(import SDBLIB "sdb_ains")
(import SDBLIB "sdb_json_get")
(import SDBLIB "sdb_json_set")
(import SDBLIB "sdb_json_inc")
(import SDBLIB "sdb_json_dec")
(import SDBLIB "sdb_json_indent")
(import SDBLIB "sdb_json_unindent")
(import SDBLIB "sdb_json_unindent")
(define (type x)
  (let (types 
         '("bool" "bool" "integer" "float" 
           "string" "symbol" "context" "primitive" 
           "cdecl" "stdcall" "quote" "list" "lambda" 
           "macro" "array"))
    (types (& 0xf ((dump x) 1)))))

; query
(define (sdb:query db var)
	(sdb_query db var))
(define (sdb:querys db var)
	(define ret (sdb_querys db nil 0 var))
	(if (= ret 0) nil (get-string ret)))
; arrays
(define (sdb:alength db key)
	(sdb_alength db key))
(define (sdb:aset db key idx val)
	(sdb_aset db key idx val 0))
(define (sdb:ains db key idx val)
	(sdb_ains db key idx val 0))
(define (sdb:adel db key idx)
	(sdb_adel db key idx 0))
(define (sdb:aget db key idx)
	(define ret (sdb_aget db key idx nil))
	(if (= ret 0) nil (get-string ret)))
; sdb
(define (sdb:hash s)
	(sdb_hash s (length s)))
(define (sdb:new file lock)
	(sdb_new file lock))
(define (sdb:set db var val)
	(sdb_set db var val 0))
(define (sdb:add db var val)
	(sdb_add db var val))
(define (sdb:inc db var val)
	(sdb_inc db var val 0))
(define (sdb:dec db var val)
	(sdb_dec db var val 0))
(define (sdb:get db var)
	(define ret (sdb_get db var 0))
	(if (= ret 0) nil (get-string ret)))
(define (sdb:free db)
	(sdb_free db))
(define (sdb:sync db)
	(sdb_sync db))
; json
(define (sdb:jsonGet db key path)
	; (set 'stats (dup "\000" 8))
	(let (ret (sdb_json_get db key path 0))
		(if (= 0 ret) "" (get-string ret))))
; TODO: fix return value, optional cas
(define (sdb:jsonInc db key path value cas)
	(sdb_json_inc db key path value cas))
; TODO: fix return value, optional cas
(define (sdb:jsonDec db key path value cas)
	(sdb_json_dec db key path value cas))
(define (sdb:jsonSet db key path value)
	(sdb_json_set db key path value nil 0))
(define (sdb:jsonIndent js)
	(let (ret (sdb_json_indent js))
		(if (= 0 ret) "" (get-string ret))))
(define (sdb:jsonUnindent js)
	(let (ret (sdb_json_unindent js))
		(if (= 0 ret) "" (get-string ret))))

(context 'MAIN)
