SUBMODULE( RealMatrix_Method ) getValues
USE BaseMethod
IMPLICIT NONE

CONTAINS

!----------------------------------------------------------------------------
!                                                                ArrayValues
!----------------------------------------------------------------------------

MODULE PROCEDURE f_getValues_Real
  Ans = obj%Val
END PROCEDURE f_getValues_Real

!----------------------------------------------------------------------------
!                                                                ArrayValues
!----------------------------------------------------------------------------

MODULE PROCEDURE f_getSectionValues_Real
  Ans = obj%Val( RIndx, CIndx )
END PROCEDURE f_getSectionValues_Real

!----------------------------------------------------------------------------
!                                                                ArrayValues
!----------------------------------------------------------------------------

MODULE PROCEDURE f_getValuesFromTriplet_Real
#define Indx iStart:iEnd:Stride
  Ans = obj%Val( Indx, Indx )
#undef Indx
END PROCEDURE f_getValuesFromTriplet_Real

!----------------------------------------------------------------------------
!                                                                ArrayValues
!----------------------------------------------------------------------------

MODULE PROCEDURE f_getValues_self
  Ans%Val = obj%Val
  CALL SetTotalDimension( Ans, 2_I4B )
END PROCEDURE f_getValues_self

!----------------------------------------------------------------------------
!                                                               ArrrayValues
!----------------------------------------------------------------------------

MODULE PROCEDURE f_getSectionValues_Self
  Ans%Val = obj%Val( RIndx, CIndx )
  CALL SetTotalDimension( Ans, 2_I4B )
END PROCEDURE f_getSectionValues_Self

!----------------------------------------------------------------------------
!                                                                ArrayValues
!----------------------------------------------------------------------------

MODULE PROCEDURE f_getValuesFromTriplet_self
#define Indx iStart:iEnd:Stride
  Ans%Val= obj%Val( Indx, Indx )
#undef Indx
  CALL SetTotalDimension( Ans, 2_I4B )
END PROCEDURE f_getValuesFromTriplet_self

!----------------------------------------------------------------------------
!                                                                 ArrayValues
!----------------------------------------------------------------------------

MODULE PROCEDURE f_getValues_1
  INTEGER( I4B ) :: s( 2 ), i, j, r1, r2, c1, c2
  INTEGER( I4B ), ALLOCATABLE :: rc( :, : )

  s = SHAPE( obj ); ALLOCATE( rc( 0 : 2, 0 : ( s( 1 ) * s( 2 ) ) ) ); rc = 0
  DO j = 1, s( 2 )
    DO i = 1, s( 1 )
      rc( 1:2, i+( j-1 )*s( 1 ) ) = SHAPE( obj( i, j ) )
    END DO
  END DO
  i = MAXVAL( SUM( RESHAPE( rc( 1, 1: ), SHAPE( obj ) ), 1 ) )
  j = MAXVAL( SUM( RESHAPE( rc( 2, 1: ), SHAPE( obj ) ), 2 ) )
  ALLOCATE( Ans( i, j ) ); Ans = 0.0_DFP
  c1 = 0; c2 = 0
  DO j = 1, s( 2 )
    c1 = 1 + c2
    c2 = c1 + rc( 2, j ) - 1
    r1 = 0; r2 = 0
    DO i = 1, s( 1 )
      r1 = 1 + r2
      r2 = r1 + rc( 1, i ) - 1
      Ans( r1:r2, c1:c2 ) = obj( i, j )%Val
    END DO
  END DO
END PROCEDURE f_getValues_1

!----------------------------------------------------------------------------
!                                                                 getValues
!----------------------------------------------------------------------------

MODULE PROCEDURE f_getValues_2
  Ans%Val = ArrayValues( obj, TypeDFP )
  CALL setTotalDimension( Ans, 2_I4B )
END PROCEDURE f_getValues_2

!----------------------------------------------------------------------------
!                                                                       Copy
!----------------------------------------------------------------------------

MODULE PROCEDURE Copy_obj_to_Val
  To = From%Val
END PROCEDURE Copy_obj_to_Val

!----------------------------------------------------------------------------
!                                                                       Copy
!----------------------------------------------------------------------------

MODULE PROCEDURE Copy_obj_to_obj
  To%Val = From%Val
  CALL SetTotalDimension( To, 2_I4B )
END PROCEDURE Copy_obj_to_obj

!----------------------------------------------------------------------------
!                                                                       Copy
!----------------------------------------------------------------------------

MODULE PROCEDURE Copy_Val_to_obj
  To%Val = From
  CALL SetTotalDimension( To, 2_I4B )
END PROCEDURE Copy_Val_to_obj

!----------------------------------------------------------------------------
!                                                               ArrayPointer
!----------------------------------------------------------------------------

MODULE PROCEDURE f_getPointer_Real
  Ans => obj%Val
END PROCEDURE f_getPointer_Real

END SUBMODULE getValues