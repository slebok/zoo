;-----------------------------------;
;           >>>Pico-ag<<<           ;
;            Theo D'Hondt           ;
;   Lab voor Programmeerkunde VUB   ;
;               ©1995               ;
;        Wolfgang De Meuter         ;
;               ©2003               ;
;-----------------------------------;

(define _VOI_TAG_  0)
(define _NBR_TAG_  1)
(define _FRC_TAG_  2)
(define _TXT_TAG_  3)
(define _SYM_TAG_  4)
(define _FUN_TAG_  5)
(define _TAB_TAG_  6)
(define _NAT_TAG_  7)
(define _DEF_TAG_  8)
(define _SET_TAG_  9)
(define _VAR_TAG_ 10)
(define _TBL_TAG_ 11)
(define _APL_TAG_ 12)
(define _DCT_TAG_ 13)

(define _TAB_TAB_ (vector #f  ;_VOI_TAG_
                          #f  ;_NBR_TAG_
                          #f  ;_FRC_TAG_
                          #f  ;_TXT_TAG_
                          #f  ;_SYM_TAG_
                          #t  ;_FUN_TAG_
                          #t  ;_TAB_TAG_
                          #t  ;_NAT_TAG_
                          #t  ;_DEF_TAG_
                          #t  ;_SET_TAG_
                          #t  ;_VAR_TAG_
                          #t  ;_TBL_TAG_
                          #t  ;_APL_TAG_
                          #t));_DCT_TAG_
(define (_AG_TAB_???_ tag)
  (vector-ref _TAB_TAB_ tag))

(define (_AG_ASSERT_  ag . tags)
  (if (member (car ag) tags)
      ag
      (_error_ (list "abstract grammar violation:" ag "expected:" tags))))

(define (_AG_TAG_ ag)
  (cond ((integer? ag) _NBR_TAG_)
        ((number? ag) _FRC_TAG_)
        ((string? ag) _TXT_TAG_)
        ((symbol? ag) _SYM_TAG)
        (else (car ag))))

(define (_AG_MAKE_VOI_ )
  (cons _VOI_TAG_ (vector)))

(define (_AG_MAKE_NBR_ nbr)
  nbr)
(define (_AG_NBR_nbr_ ag)
  ag)

(define (_AG_MAKE_FRC_ frc)
  frc)
(define (_AG_FRC_frc_ ag)
  ag)

(define (_AG_MAKE_TXT_ txt)
  txt)
(define (_AG_TXT_txt_ ag)
  ag)
         
(define (_AG_MAKE_SYM_ sym)
  sym)
(define (_AG_SYM_sym_ ag)
  ag)

(define (_AG_MAKE_FUN_ nam par bod env)
  (cons _FUN_TAG_ (vector nam par bod env)))
(define (_AG_FUN_nam_ ag)
 (vector-ref (cdr (_AG_ASSERT_ ag _FUN_TAG_)) 0))
(define (_AG_FUN_par_ ag)
  (vector-ref (cdr (_AG_ASSERT_ ag _FUN_TAG_)) 1))
(define (_AG_FUN_bod_ ag)
  (vector-ref (cdr (_AG_ASSERT_ ag _FUN_TAG_)) 2))
(define (_AG_FUN_dct_ ag)
  (vector-ref (cdr (_AG_ASSERT_ ag _FUN_TAG_)) 3))
(define (_AG_FUN_set_ ag dct)
  (vector-set! (cdr  (_AG_ASSERT_ ag _FUN_TAG_)) 3 dct))

(define (_AG_MAKE_TAB_ siz ini)
  (let* ((vec (make-vector siz ())))
    (do ((idx 0 (+ idx 1)))
      ((= idx siz))
      (vector-set! vec idx (ini)))
    (cons _TAB_TAG_ vec)))
(define (_AG_TAB_siz_ ag)
  (vector-length (cdr (_AG_ASSERT_ ag _TAB_TAG_))))
(define (_AG_TAB_get_ ag idx)
  (let* ((vec (cdr ag ))
         (siz (vector-length vec))) 
    (if (and (positive? idx) (<= idx siz) (integer? idx))
        (vector-ref vec (- idx 1))
        (_error_ "index out of range"))))
(define (_AG_TAB_set_ ag idx val)
  (if (eq? ag _emp_)
      _emp_
      (let* ((vec (cdr ag))
             (siz (vector-length vec)))
        (if (and (positive? idx) (<= idx siz) (integer? idx))
            (vector-set! vec (- idx 1) val)
            (_error_ "index out of range"))
        ag)))
(define (_AG_TAB_map_ ag proc)
  (if (eq? ag _emp_)
      _emp_
      (let* ((vec (cdr (_AG_ASSERT_ ag _TAB_TAG_)))
             (siz (vector-length vec))
             (new-vec (make-vector siz)))
        (do ((idx 0 (+ idx 1)))
          ((= idx siz))
          (vector-set! new-vec idx (proc (vector-ref vec idx))))
        (cons _TAB_TAG_ new-vec))))
(define (_AG_TAB_for_each_ ag proc default)
  (let* ((vec (cdr (_AG_ASSERT_ ag _TAB_TAG_)))
         (siz (vector-length vec)))
    (do ((result default)
         (idx 0 (+ idx 1)))
      ((= idx siz) result)
      (set! result (proc (vector-ref vec idx))))))

(define (_AG_MAKE_NAT_ nam nat)
  (cons _NAT_TAG_ (vector nam nat)))
(define (_AG_NAT_nam_ ag)
  (vector-ref (cdr (_AG_ASSERT_ ag _NAT_TAG_)) 0))
(define (_AG_NAT_nat_ ag)
  (vector-ref (cdr (_AG_ASSERT_ ag _NAT_TAG_)) 1))

(define (_AG_MAKE_VAR_ nam)
  (cons _VAR_TAG_ (vector nam)))
(define (_AG_VAR_nam_ ag)
  (vector-ref (cdr (_AG_ASSERT_ ag _VAR_TAG_)) 0))

(define (_AG_MAKE_DEF_ inv val)
  (cons _DEF_TAG_ (vector inv val)))
(define (_AG_DEF_inv_ ag)
  (vector-ref (cdr (_AG_ASSERT_ ag _DEF_TAG_)) 0))
(define (_AG_DEF_exp_ ag)
  (vector-ref (cdr (_AG_ASSERT_ ag _DEF_TAG_)) 1))

(define (_AG_MAKE_SET_ inv val)
  (cons _SET_TAG_ (vector inv val)))
(define (_AG_SET_inv_ ag)
  (vector-ref (cdr (_AG_ASSERT_ ag _SET_TAG_)) 0))
(define (_AG_SET_exp_ ag)
  (vector-ref (cdr (_AG_ASSERT_ ag _SET_TAG_)) 1))

(define (_AG_MAKE_TBL_ nam exp)
  (cons _TBL_TAG_ (vector nam exp)))
(define (_AG_TBL_nam_ ag)
  (vector-ref (cdr (_AG_ASSERT_ ag _TBL_TAG_)) 0))
(define (_AG_TBL_idx_ ag)
  (vector-ref (cdr (_AG_ASSERT_ ag _TBL_TAG_)) 1))

(define (_AG_MAKE_APL_ nam arg)
  (cons _APL_TAG_ (vector nam arg)))
(define (_AG_APL_nam_ ag)
  (vector-ref (cdr (_AG_ASSERT_ ag _APL_TAG_)) 0))
(define (_AG_APL_arg_ ag)
  (vector-ref (cdr (_AG_ASSERT_ ag _APL_TAG_)) 1))

(define (_AG_MAKE_DCT_ nam val dct)
  (cons _DCT_TAG_ (vector nam val dct)))
(define (_AG_DCT_nam_ ag)
  (vector-ref (cdr  (_AG_ASSERT_ ag _DCT_TAG_)) 0))
(define (_AG_DCT_val_ ag)
  (vector-ref (cdr  (_AG_ASSERT_ ag _DCT_TAG_)) 1))
(define (_AG_DCT_set_ ag val)
  (vector-set! (cdr  (_AG_ASSERT_ ag _DCT_TAG_)) 1 val))
(define (_AG_DCT_dct_ ag)
  (vector-ref (cdr (_AG_ASSERT_ ag _DCT_TAG_)) 2))
