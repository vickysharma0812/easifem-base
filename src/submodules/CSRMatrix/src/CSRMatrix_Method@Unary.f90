! This program is a part of EASIFEM library
! Copyright (C) 2020-2021  Vikas Sharma, Ph.D
!
! This program is free software: you can redistribute it and/or modify
! it under the terms of the GNU General Public License as published by
! the Free Software Foundation, either version 3 of the License, or
! (at your option) any later version.
!
! This program is distributed in the hope that it will be useful,
! but WITHOUT ANY WARRANTY; without even the implied warranty of
! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
! GNU General Public License for more details.
!
! You should have received a copy of the GNU General Public License
! along with this program.  If not, see <https: //www.gnu.org/licenses/>
!

!> authors: Vikas Sharma, Ph. D.
! date: 	22 March 2021
! summary: 	Unary operator for [[SparseMaatrix_]]
!
! Following subroutines are planned to include in this module
!
! | subroutine  | description  |
! |---|---|
! | `SUBMAT` | extracts a submatrix from a sparse matrix |
! | `FILTER` | filters elements from a matrix according to their magnitude |
! | `CSORT`  | sorts the elements in increasing order of columns |
! | `CLNCSR`  | clean up the CSR format matrix, remove duplicate entry, etc |
! | `TRANSP` | in-place transposition routine |
! | `COPMAT` | copy of a matrix into another matrix (both stored csr)    |
! | `GETELM` | returns a(i,j) for any (i,j) from a CSR-stored matrix.     |
! | `GETDIA` | extracts a specified diagonal from a matrix.                |
! | `GETL`   | extracts lower triangular part |
! | `GETU`   | extracts upper triangular part |
! | `LEVELS` | gets the level scheduling structure for lower triangular matrices |
! | `AMASK`  | extracts C = A mask M |
! | `RPERM`  | permutes the rows of a matrix (B = P A) |
! | `CPERM`  | permutes the columns of a matrix (B = A Q) |
! | `DPERM`  | permutes both the rows and columns of a matrix (B = P A Q ) |
! | `DPERM1` | general extraction routine (extracts arbitrary rows) |
! | `DPERM2` | general submatrix permutation/extraction routine            |
! | `DVPERM` | permutes a real vector (in-place)                           |
! | `IVPERM` | permutes an integer vector (in-place)                       |
! | `RETMX`  | returns the max absolute value in each row of the matrix    |
! | `DIAPOS` | returns the positions of the diagonal elements in A.        |
! | `EXTBDG` | extracts the main diagonal blocks of a matrix.              |
! | `GETBWD` | returns the bandwidth information on a matrix.              |
! | `BLKFND` | finds the block-size of a matrix.                           |
! | `BLKCHK` | checks whether a given integer is the block size of A.      |
! | `INFDIA` | obtains information on the diagonals of A.                  |
! | `AMUBDG` | gets number of nonzeros in each row of A*B (as well as NNZ) |
! | `APLBDG` | gets number of nonzeros in each row of A+B (as well as NNZ) |
! | `RNRMS`  | computes the norms of the rows of A                         |
! | `CNRMS`  | computes the norms of the columns of A                      |
! | `ROSCAL` | scales the rows of a matrix by their norms.                 |
! | `COSCAL` | scales the columns of a matrix by their norms.              |
! | `ADDBLK` | Adds a matrix B into a block of A.                          |
! | `GET1UP` | Collects the first elements of each row of the upper triangular portion of the matrix |
! | `XTROWS` | extracts given rows from a matrix in CSR format.            |
! | `CSRKVSTR`|  Finds block row partitioning of matrix in CSR format      |
! | `CSRKVSTC`|  Finds block column partitioning of matrix in CSR format   |
! | `KVSTMERGE`| Merges block partitionings, for conformal row/col pattern |

SUBMODULE( CSRMatrix_Method ) Unary
USE BaseMethod
IMPLICIT NONE
CONTAINS

!----------------------------------------------------------------------------
!                                                                    Convert
!----------------------------------------------------------------------------

MODULE PROCEDURE crsMat_convert_internally
  INTEGER( I4B ) :: i, j, nrow
  nrow = SIZE( IA ) - 1
  CALL Reallocate( mat, nrow, nrow )
  DO i = 1, nrow
    DO j = IA( i ), IA( i + 1 ) - 1
      mat( i, JA( j ) ) = A( j )
    END DO
  END DO
END PROCEDURE crsMat_convert_internally

!----------------------------------------------------------------------------
!                                                                    Convert
!----------------------------------------------------------------------------

MODULE PROCEDURE crsMat_Convert
  INTEGER( I4B ) :: i, j
  CALL crsMat_convert_internally( A=From%A, IA=From%csr%IA, JA=From%csr%JA, &
    & mat=To )
END PROCEDURE crsMat_Convert

!----------------------------------------------------------------------------
!                                                                    ColSORT
!----------------------------------------------------------------------------

MODULE PROCEDURE csrMat_ColumnSORT
  CALL CSORT( obj%csr%nrow, obj%A, obj%csr%JA, obj%csr%IA, &
    & INPUT( Option = isValues, Default = .TRUE. ) )
  obj%csr%isSorted = .TRUE.
END PROCEDURE csrMat_ColumnSORT

!----------------------------------------------------------------------------
!                                                           RemoveDuplicates
!----------------------------------------------------------------------------

MODULE PROCEDURE csrMat_RemoveDuplicates
  INTEGER( I4B ), ALLOCATABLE :: iwk( : ), UT( : )
  CALL Reallocate( UT, obj%csr%nrow, iwk, obj%csr%nrow+1 )
  CALL CLNCSR( 1, 1, obj%csr%nrow, obj%A, obj%csr%JA, obj%csr%IA, UT, iwk )
  !> Some entries are removed so fix sparsity
  obj%csr%isSparsityLock = .FALSE.
  CALL setSparsity( obj )
  DEALLOCATE( iwk, UT )
END PROCEDURE csrMat_RemoveDuplicates

!----------------------------------------------------------------------------
!                                                                      Clean
!----------------------------------------------------------------------------

MODULE PROCEDURE csrMat_Clean
  INTEGER( I4B ), ALLOCATABLE :: iwk( : ), UT( : )
  INTEGER( I4B ) :: value2

  IF( INPUT( option=isValues, default=.TRUE. )) THEN
    value2 = 1
  ELSE
    value2 = 0
  END IF
  CALL Reallocate( UT, obj%csr%nrow, iwk, obj%csr%nrow+1 )
  CALL CLNCSR( INPUT(option=ExtraOption, default=1), value2, obj%csr%nrow, &
    & obj%A, obj%csr%JA, obj%csr%IA, UT, iwk )
  !> Some entries are removed so fix sparsity
  obj%csr%isSparsityLock = .FALSE.
  CALL setSparsity( obj )
  DEALLOCATE( iwk, UT )
END PROCEDURE csrMat_Clean

!----------------------------------------------------------------------------
!                                                                      Copy
!----------------------------------------------------------------------------

MODULE PROCEDURE csrMat_Copy
  To = From
END PROCEDURE csrMat_Copy

!----------------------------------------------------------------------------
!                                                                      get
!----------------------------------------------------------------------------

MODULE PROCEDURE csrMat_Get1
  INTERFACE
    FUNCTION GETELM(I,J,A,JA,IA,IADD,SORTED)
      INTEGER :: I, J, IA( * ), JA( * ), IADD
      LOGICAL :: SORTED
      DOUBLE PRECISION :: GETELM, A( * )
    END FUNCTION GETELM
  END INTERFACE
  INTEGER( I4B ) :: iadd
  Ans = GETELM( I, J, obj%A, obj%csr%JA, obj%csr%IA, iadd, obj%csr%isSorted)
END PROCEDURE csrMat_Get1

!----------------------------------------------------------------------------
!                                                                    Filter
!----------------------------------------------------------------------------

MODULE PROCEDURE csrMat_DropEntry
  INTEGER( I4B ) :: ierr, nnz
  INTEGER( I4B ), ALLOCATABLE :: IA( : ), JA( : )
  REAL( DFP ), ALLOCATABLE :: A( : )
  ALLOCATE( IA( objIn%csr%nrow + 1 ), JA( objIn%csr%nnz ), &
    & A( objIn%csr%nnz ) )
  CALL FILTER( objIn%csr%nrow, INPUT( option=option, default=1 ), &
    & droptol, objIn%A, objIn%csr%JA, objIn%csr%IA, A, JA, IA,&
    & objIn%csr%nnz, ierr )
  nnz = IA( objIn%csr%nrow + 1 ) - 1
  CALL Initiate( obj=objOut, A=A( 1:nnz ), IA=IA, JA=JA( 1:nnz ) )
  DEALLOCATE( IA, JA, A )
END PROCEDURE csrMat_DropEntry

!----------------------------------------------------------------------------
!                                                                 Transpose
!----------------------------------------------------------------------------

MODULE PROCEDURE csrMat_Transpose
  INTEGER( I4B ), ALLOCATABLE :: iwk( : )
  INTEGER( I4B ) :: ierr
  CALL Reallocate( iwk, obj%csr%nnz )
  CALL TRANSP(obj%csr%nrow,obj%csr%ncol,obj%A,obj%csr%JA,obj%csr%IA,iwk,ierr)
  IF( ierr .NE. 0 ) THEN
    CALL ErrorMSG( &
      & "Error occured during transposing!", &
      & "CSRMatrix_Method@Unary.f90", &
      & "csrMat_Transpose()", &
      & __LINE__, stderr )
    STOP
  END IF
  CALL ColumnSORT( obj )
  DEALLOCATE( iwk )
END PROCEDURE csrMat_Transpose

!----------------------------------------------------------------------------
!                                                                 getDiagonal
!----------------------------------------------------------------------------

MODULE PROCEDURE csrMat_getDiagonal
  INTEGER( I4B ) :: len, off
  off = INPUT( option=offset, default=0 )
  CALL Reallocate( diag, obj%csr%nrow, idiag, obj%csr%nrow )
  CALL GETDIA(obj%csr%nrow,obj%csr%ncol,0,obj%A,obj%csr%JA,obj%csr%IA,&
    & len,diag,idiag,off)
END PROCEDURE csrMat_getDiagonal

!----------------------------------------------------------------------------
!                                                          getLowerTriangle
!----------------------------------------------------------------------------

MODULE PROCEDURE csrMat_getLowerTriangle
  REAL( DFP ), ALLOCATABLE :: A( : )
  INTEGER( I4B ), ALLOCATABLE :: IA( : ), JA( : )
  INTEGER( I4B ) :: nnz, nrow
  nrow = obj%csr%nrow; nnz = obj%csr%nnz
  ALLOCATE( A( nnz ), JA( nnz ), IA( nrow + 1) )
  CALL GETL(obj%csr%nrow,obj%A,obj%csr%JA,obj%csr%IA,A,JA,IA)
  nnz = IA( nrow + 1 ) - 1
  CALL Initiate( obj=L, A=A(1:nnz), IA=IA, JA=JA(1:nnz) )
  DEALLOCATE( A, IA, JA )
END PROCEDURE csrMat_getLowerTriangle

!----------------------------------------------------------------------------
!                                                          getUpperTriangle
!----------------------------------------------------------------------------

MODULE PROCEDURE csrMat_getUpperTriangle
  REAL( DFP ), ALLOCATABLE :: A( : )
  INTEGER( I4B ), ALLOCATABLE :: IA( : ), JA( : )
  INTEGER( I4B ) :: nnz, nrow
  nrow = obj%csr%nrow; nnz = obj%csr%nnz
  ALLOCATE( A( nnz ), JA( nnz ), IA( nrow + 1) )
  CALL GETU(obj%csr%nrow,obj%A,obj%csr%JA,obj%csr%IA,A,JA,IA)
  nnz = IA( nrow + 1 ) - 1
  CALL Initiate( obj=U, A=A(1:nnz), IA=IA, JA=JA(1:nnz) )
  DEALLOCATE( A, IA, JA )
END PROCEDURE csrMat_getUpperTriangle

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------
END SUBMODULE Unary