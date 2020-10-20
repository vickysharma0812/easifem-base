SUBMODULE (RealMatrix_Method) Constructor
USE BaseMethod

IMPLICIT NONE

CONTAINS

!----------------------------------------------------------------------------
!                                                                      Shape
!----------------------------------------------------------------------------

MODULE PROCEDURE get_shape
  IF( ALLOCATED( Obj % Val ) ) THEN
    Ans = SHAPE( Obj % Val )
  ELSE
    Ans = 0
  END IF
END PROCEDURE get_shape

!----------------------------------------------------------------------------
!                                                                       Size
!----------------------------------------------------------------------------

MODULE PROCEDURE get_size
  !Define internal variables
  INTEGER( I4B ) :: S( 2 )
  IF( ALLOCATED( Obj % Val ) ) THEN
    S = SHAPE( Obj % Val )
    IF( PRESENT( Dims ) ) THEN
      Ans = S( Dims )
    ELSE
      Ans = S( 1 ) * S( 2 )
    END IF
  ELSE
    Ans = 0
  END IF
END PROCEDURE get_size

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

MODULE PROCEDURE allocate_data
  IF( ALLOCATED( Obj % Val ) ) THEN
    IF( ANY( SHAPE( Obj % Val ) .NE. Dims ) ) THEN
      DEALLOCATE( Obj % Val )
      ALLOCATE( Obj % Val( Dims(1), Dims( 2 ) ) )
      Obj % Val = 0
    ELSE
      Obj % Val = 0
    END IF
  ELSE
    ALLOCATE( Obj % Val( Dims( 1 ), Dims( 2 ) ) )
    Obj % Val = 0
  END IF
  CALL setTotalDimension( Obj, 2_I4B )
END PROCEDURE allocate_data

!----------------------------------------------------------------------------
!                                                                    Display
!----------------------------------------------------------------------------

MODULE PROCEDURE Display_Obj
  INTEGER( I4B ) :: I
  IF( PRESENT( UnitNo ) ) THEN
    I = UnitNo
  ELSE
    I = stdout
  END IF
  IF( LEN_TRIM( msg ) .NE. 0 ) WRITE( I, "(A)") TRIM( Msg )
  CALL Display( Obj % Val, "", I )
END PROCEDURE Display_Obj

!----------------------------------------------------------------------------
!                                                                    Display
!----------------------------------------------------------------------------

MODULE PROCEDURE Display_Obj_vec
  INTEGER( I4B ) :: I, j
  IF( PRESENT( UnitNo ) ) THEN
    I = UnitNo
  ELSE
    I = stdout
  END IF
  IF( LEN_TRIM( msg ) .NE. 0 ) WRITE( I, "(A)") TRIM( Msg )
  DO j = 1, SIZE( Obj )
    CALL Display( Obj( j ) % Val, "", I )
    CALL Blanklines( UnitNo = I, NOL = 1 )
  END DO
END PROCEDURE Display_Obj_vec

!----------------------------------------------------------------------------
!                                                             DeallocateData
!----------------------------------------------------------------------------

MODULE PROCEDURE Deallocate_Data
  IF( ALLOCATED( Obj % Val ) ) DEALLOCATE( Obj % Val )
  CALL setTotalDimension( Obj, 0 )
END PROCEDURE Deallocate_Data

!----------------------------------------------------------------------------
!                                                                   Initiate
!----------------------------------------------------------------------------

MODULE PROCEDURE initiate_obj
  CALL AllocateData( Obj, Dims )
END PROCEDURE initiate_obj

!----------------------------------------------------------------------------
!                                                                   Initiate
!----------------------------------------------------------------------------

MODULE PROCEDURE initiate_obj_vector_a
  INTEGER( I4B ) :: j
  DO j = 1, SIZE( Obj )
    CALL AllocateData( Obj( j ), Dims )
  END DO
END PROCEDURE initiate_obj_vector_a

!----------------------------------------------------------------------------
!                                                                   Initiate
!----------------------------------------------------------------------------

MODULE PROCEDURE initiate_obj_vector_b
  INTEGER( I4B ) :: j
  DO j = 1, SIZE( Obj )
    CALL AllocateData( Obj( j ), Dims( j, : ) )
  END DO
END PROCEDURE initiate_obj_vector_b

!----------------------------------------------------------------------------
!                                                                   Initiate
!----------------------------------------------------------------------------

MODULE PROCEDURE initiate_obj_val
  Obj % Val = Val
  CALL setTotalDimension( Obj, 2_I4B )
END PROCEDURE initiate_obj_val

!----------------------------------------------------------------------------
!                                                                     Matrix
!----------------------------------------------------------------------------

MODULE PROCEDURE Constructor1
  CALL Initiate( Obj, Dims )
END PROCEDURE Constructor1

!----------------------------------------------------------------------------
!                                                                        Eye
!----------------------------------------------------------------------------

MODULE PROCEDURE eye_int
  INTEGER( I4B ) :: i
  Ans = 0_I4B
  DO i = 1, m
    Ans( i, i ) = 1
  END DO
END PROCEDURE eye_int

!----------------------------------------------------------------------------
!                                                                        Eye
!----------------------------------------------------------------------------

MODULE PROCEDURE eye_real
  INTEGER( I4B ) :: i
  Ans = 0.0
  DO i = 1, m
    Ans( i, i ) = 1.0
  END DO
END PROCEDURE eye_real

!----------------------------------------------------------------------------
!                                                                        Eye
!----------------------------------------------------------------------------

MODULE PROCEDURE eye_real_b
  INTEGER( I4B ) :: i
  Ans = 0.0
  DO i = 1, m
    Ans( i, i ) = 1.0
  END DO
END PROCEDURE eye_real_b

!----------------------------------------------------------------------------
!                                                                        Eye
!----------------------------------------------------------------------------

MODULE PROCEDURE eye_obj
  INTEGER( I4B ) :: i
  CALL Initiate( Ans, [m,m] )
  DO i = 1, m
    Ans % Val ( i, i ) = 1.0
  END DO
END PROCEDURE eye_obj

!----------------------------------------------------------------------------
!                                                                    Convert
!----------------------------------------------------------------------------

MODULE PROCEDURE convert_doftonodes
  INTEGER( I4B ) :: m, inode, idof, i, j
  INTEGER( I4B ), ALLOCATABLE :: T( :, : )

  m = nns * tdof
  ALLOCATE( T( m, m ) )
  T = Eye( m, TypeInt )

  SELECT CASE( Conversion )
  CASE( DofToNodes )
    DO inode  = 1, nns
      DO idof = 1, tdof
        j = (inode - 1)* tdof + idof
        T( j, j ) = 0
        i = (idof - 1)*nns + inode
        T( i, j ) = 1
      END DO
    END DO
  CASE( NodesToDOF )
    DO idof = 1, tdof
      DO inode  = 1, nns
        j = (idof - 1)* nns + inode
        T( j, j ) = 0
        i = (inode - 1)* tdof + idof
        T( i, j ) = 1
      END DO
    END DO
  END SELECT

  to = MATMUL( TRANSPOSE( T ), MATMUL( from, T ) )
  DEALLOCATE( T )

END PROCEDURE convert_doftonodes

!----------------------------------------------------------------------------
!                                                                 Convert
!----------------------------------------------------------------------------

MODULE PROCEDURE realmat_convert_doftonodes
  CALL Convert( From=From%val, To=To%val, Conversion=Conversion, nns=nns, &
    & tdof=tdof )
END PROCEDURE realmat_convert_doftonodes

!----------------------------------------------------------------------------
!                                                                   Convert
!----------------------------------------------------------------------------

MODULE PROCEDURE convert_mat4_to_mat2
  !   Define internal variables
  INTEGER( I4B ) :: a, b, I( 4 ), r1, r2, c1, c2

  I = SHAPE( From )
  CALL Reallocate( To, I(1)*I(3), I(2)*I(4) )
  c1 = 0; c2 = 0
  DO b = 1, I(4)
    c1 = c2 + 1
    c2 = b * I(2)
    r1 = 0; r2 = 0
    DO a = 1, I(3)
      r1 = r2 + 1;
      r2 = a * I(1)
      To( r1 : r2, c1 : c2 ) = From( :, :, a, b )
    END DO
  END DO
END PROCEDURE convert_mat4_to_mat2

!----------------------------------------------------------------------------
!                                                                       Sym
!----------------------------------------------------------------------------

MODULE PROCEDURE sym_array
  Ans = 0.5_DFP * ( Obj + TRANSPOSE( Obj ) )
END PROCEDURE sym_array

!----------------------------------------------------------------------------
!                                                                       Sym
!----------------------------------------------------------------------------

MODULE PROCEDURE sym_obj
  Ans % Val = 0.5_DFP * ( Obj % Val + TRANSPOSE( Obj % Val ) )
END PROCEDURE sym_obj

!----------------------------------------------------------------------------
!                                                                    SkewSym
!----------------------------------------------------------------------------

MODULE PROCEDURE SkewSym_array
  Ans = 0.5_DFP * ( Obj - TRANSPOSE( Obj ) )
END PROCEDURE SkewSym_array

!----------------------------------------------------------------------------
!                                                                    SkewSym
!----------------------------------------------------------------------------

MODULE PROCEDURE SkewSym_obj
  Ans % Val = 0.5_DFP * ( Obj % Val - TRANSPOSE( Obj % Val ) )
END PROCEDURE SkewSym_obj

!----------------------------------------------------------------------------
!                                                         MakeDiagonalCopies
!----------------------------------------------------------------------------

MODULE PROCEDURE realmat_make_diag_copy1
  INTEGER( I4B ) :: I, S( 2 )
  REAL( DFP ), ALLOCATABLE :: DummyMat2( :, : )

  IF( ALLOCATED( Mat ) ) THEN
    S = SHAPE( Mat )
    DummyMat2 = Mat
    DEALLOCATE( Mat )
    ALLOCATE( Mat( S( 1 )*nCopy, S( 2 )*nCopy ) )
    Mat = 0.0_DFP
    DO I = 1, nCopy
        Mat( ( I - 1 ) * S( 1 ) + 1 : I * S( 1 ), &
        & ( I - 1 ) * S( 2 ) + 1 : I * S( 2 ) ) &
        & = DummyMat2( :, : )
    END DO
    DEALLOCATE( DummyMat2 )
  END IF
END PROCEDURE realmat_make_diag_copy1

!----------------------------------------------------------------------------
!                                                         MakeDiagonalCopies
!----------------------------------------------------------------------------

MODULE PROCEDURE realmat_make_diag_copy2
  INTEGER( I4B ) :: I, S( 2 )
  S = SHAPE( From )
  CALL Reallocate( To, S( 1 )*nCopy, S( 2 )*nCopy )
  To = 0.0_DFP
  DO I = 1, nCopy
      To( ( I - 1 ) * S( 1 ) + 1 : I * S( 1 ), &
      & ( I - 1 ) * S( 2 ) + 1 : I * S( 2 ) ) &
      & = From( :, : )
  END DO
END PROCEDURE realmat_make_diag_copy2

!----------------------------------------------------------------------------
!                                                         MakeDiagonalCopies
!----------------------------------------------------------------------------

MODULE PROCEDURE realmat_make_diag_copy3
  CALL realmat_make_diag_copy1( Mat = Mat % Val, nCopy = nCopy )
END PROCEDURE realmat_make_diag_copy3

!----------------------------------------------------------------------------
!                                                         MakeDiagonalCopies
!----------------------------------------------------------------------------

MODULE PROCEDURE realmat_make_diag_copy4
  CALL realmat_make_diag_copy2( From = From % Val, To = To % Val, &
    & nCopy = nCopy )
END PROCEDURE realmat_make_diag_copy4

!----------------------------------------------------------------------------
!                                                              Random_Number
!----------------------------------------------------------------------------

MODULE PROCEDURE realmat_random_number
  IF( PRESENT( m ) .AND. PRESENT( n ) ) THEN
    CALL Reallocate( Obj%Val, m, n )
    CALL RANDOM_NUMBER( Obj%Val )
    RETURN
  END IF

  IF( PRESENT( m ) ) THEN
    CALL Reallocate( Obj%Val, m, m )
    CALL RANDOM_NUMBER( Obj%Val )
    RETURN
  END IF

  IF( PRESENT( n ) ) THEN
    CALL Reallocate( Obj%Val, n, n )
    CALL RANDOM_NUMBER( Obj%Val )
    RETURN
  END IF

  CALL RANDOM_NUMBER( Obj%Val )

END PROCEDURE realmat_random_number

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------
END SUBMODULE Constructor