MODULE FEMatrix_Module
!! This module contains interfaces of finite element matrices
USE BaseType
USE GlobalData
IMPLICIT NONE
PRIVATE

!----------------------------------------------------------------------------
!                                                       MassMatrix@MassMatrix
!----------------------------------------------------------------------------

INTERFACE
!! This subroutine makes mass matrix in space domain

!> authors: Dr. Vikas Sharma
!
! This subroutine makes space matrix in space domain, Here Rho $\rho$ is a
! finite element variable
!
! $$\int_{\Omega } N^{I}\rho N^{J}d\Omega$$
MODULE PURE FUNCTION Space_MassMatrix( Test, Trial, Rho, nCopy ) RESULT( Ans )
  CLASS( ElemshapeData_ ), INTENT( IN ) :: Test
    !! Shapedata for test function
  CLASS( ElemshapeData_ ), INTENT( IN ) :: Trial
    !! Shapedata for trial function
  CLASS( FEVariable_ ), INTENT( IN ), OPTIONAL :: Rho
    !! Finite element variable (density)
  INTEGER( I4B ), INTENT( IN ), OPTIONAL :: nCopy
    !! number of diagonal copies
  REAL( DFP ), ALLOCATABLE :: Ans( :, : )
END FUNCTION Space_MassMatrix
END INTERFACE

!----------------------------------------------------------------------------
!                                                                 MassMatrix
!----------------------------------------------------------------------------

INTERFACE
!! This subroutine makes mass matrix in space time domain

!> authors: Dr. Vikas Sharma
!
! This subroutine makes space matrix in space domain, Here Rho $\rho$ is a
! finite element variable. Following expression can be evaluated
!
! $$\int_{\Omega } N^{I}T_{a}\rho N^{J}T_{b}d\Omega$$
! $$\iint \frac{\partial N^{I}T_{a}}{\partial t} \rho N^{J}T_{b}d\Omega dt$$
! $$\iint \frac{\partial N^{I}T_{a}}{\partial t} \rho \frac{\partial
! N^{J}T_{b}}{\partial t} d\Omega dt$$
! $$\iint N^{I}T_{a}\rho \frac{\partial N^{J}T_{b}}{\partial t} d\Omega dt$$

MODULE PURE FUNCTION st_massMatrix_a( Test, Trial, Rho, Term1, Term2, nCopy )&
  & RESULT( Ans )
  CLASS( STElemshapeData_ ), INTENT( IN ) :: Test(:)
  CLASS( STElemshapeData_ ), INTENT( IN ) :: Trial(:)
  TYPE( FEVariable_ ), OPTIONAL, INTENT( IN ) :: Rho
  INTEGER( I4B ), INTENT( IN ) :: Term1
    !! If 0 then time derivative in first term true, otherwise false
  INTEGER( I4B ), INTENT( IN ) :: Term2
    !! If 0 then time derivative in second term true, otherwise false
  INTEGER( I4B ), OPTIONAL, INTENT( IN ) :: nCopy
  REAL( DFP ), ALLOCATABLE :: Ans( :, : )
END FUNCTION st_massMatrix_a
END INTERFACE

!----------------------------------------------------------------------------
!                                                                 MassMatrix
!----------------------------------------------------------------------------

!> Generic function to obtain mass matrix
INTERFACE MassMatrix
  MODULE PROCEDURE Space_MassMatrix, st_massMatrix_a
END INTERFACE MassMatrix

PUBLIC :: MassMatrix

!----------------------------------------------------------------------------
!                                            DiffusionMatrix@DiffusionMatrix
!----------------------------------------------------------------------------

INTERFACE
!! This subroutine returns the diffusion matrix in space domain

!> authors: Dr. Vikas Sharma
!
! This function returns the diffusion matrix in space domain
!
! $$\int^{}_{\Omega } \frac{\partial N^{I}}{\partial x_{i}} \frac{\partial N^
! {J}}{\partial x_{i}} d\Omega$$
MODULE PURE FUNCTION Space_DiffusionMatrix( Test, Trial, nCopy ) RESULT( Ans )
  CLASS( ElemshapeData_ ), INTENT( IN )  :: Test, Trial
  INTEGER( I4B ), INTENT( IN ), OPTIONAL :: nCopy
  REAL( DFP ), ALLOCATABLE :: Ans( :, : )
END FUNCTION Space_DiffusionMatrix
END INTERFACE

!----------------------------------------------------------------------------
!                                            DiffusionMatrix@DiffusionMatrix
!----------------------------------------------------------------------------

INTERFACE
!! This subroutine returns the diffusion matrix in space domain

!> authors: Dr. Vikas Sharma
!
! This function returns the diffusion matrix in space domain
!
! $$\int^{}_{\Omega } \frac{\partial N^{I}}{\partial x_{i}} k_{ij}
!\frac{\partial N^{J}}{\partial x_{j}} d\Omega$$
MODULE PURE FUNCTION Space_DiffusionMatrix_K( Test, Trial, K, nCopy ) &
  & RESULT( Ans )
  CLASS( ElemshapeData_ ), INTENT( IN )  :: Test, Trial
  CLASS( FEVariable_ ), INTENT( IN ) :: K
  INTEGER( I4B ), INTENT( IN ), OPTIONAL :: nCopy
  REAL( DFP ), ALLOCATABLE :: Ans( :, : )
END FUNCTION Space_DiffusionMatrix_K
END INTERFACE

!----------------------------------------------------------------------------
!                                            DiffusionMatrix@DiffusionMatrix
!----------------------------------------------------------------------------

INTERFACE
!! This subroutine returns the diffusion matrix in space domain

!> authors: Dr. Vikas Sharma
!
! This function returns the diffusion matrix in space domain
!
! $$\int^{}_{\Omega } \frac{\partial N^{I}}{\partial x_{i}} c_i
!\frac{\partial N^{J}}{\partial x_{j}} c_j d\Omega$$
MODULE PURE FUNCTION Space_DiffusionMatrix_C( Test, Trial, C1, C2, nCopy ) &
  & RESULT( Ans )
  CLASS( ElemshapeData_ ), INTENT( IN )  :: Test, Trial
  CLASS( FEVariable_ ), INTENT( IN ) :: C1, C2
  INTEGER( I4B ), INTENT( IN ), OPTIONAL :: nCopy
  REAL( DFP ), ALLOCATABLE :: Ans( :, : )
END FUNCTION Space_DiffusionMatrix_C
END INTERFACE

!----------------------------------------------------------------------------
!                                                           DiffusionMatrix
!----------------------------------------------------------------------------

INTERFACE
MODULE PURE FUNCTION st_diffusionMatrix( Test, Trial, nCopy ) RESULT( Ans )
  CLASS( STElemshapeData_ ), INTENT( IN )  :: Test( : )
  CLASS( STElemshapeData_ ), INTENT( IN )  :: Trial( : )
  INTEGER( I4B ), INTENT( IN ), OPTIONAL :: nCopy
  REAL( DFP ), ALLOCATABLE :: Ans( :, : )
END FUNCTION st_diffusionMatrix
END INTERFACE

!----------------------------------------------------------------------------
!                                                           DiffusionMatrix
!----------------------------------------------------------------------------

INTERFACE
MODULE PURE FUNCTION st_diffusionMatrix_K( Test, Trial, K, nCopy ) &
  & RESULT( Ans )
  CLASS( STElemshapeData_ ), INTENT( IN )  :: Test(:)
  CLASS( STElemshapeData_ ), INTENT( IN )  :: Trial(:)
  CLASS( FEVariable_ ), INTENT( IN ) :: K
  INTEGER( I4B ), INTENT( IN ), OPTIONAL :: nCopy
  REAL( DFP ), ALLOCATABLE :: Ans( :, : )
END FUNCTION st_diffusionMatrix_K
END INTERFACE

!----------------------------------------------------------------------------
!                                                           DiffusionMatrix
!----------------------------------------------------------------------------

INTERFACE
MODULE PURE FUNCTION st_diffusionMatrix_C( Test, Trial, C1, C2, nCopy ) &
  & RESULT( Ans )
  CLASS( STElemshapeData_ ), INTENT( IN )  :: Test( : )
  CLASS( STElemshapeData_ ), INTENT( IN )  :: Trial( : )
  CLASS( FEVariable_ ), INTENT( IN ) :: C1
  CLASS( FEVariable_ ), INTENT( IN ) :: C2
  INTEGER( I4B ), INTENT( IN ), OPTIONAL :: nCopy
  REAL( DFP ), ALLOCATABLE :: Ans( :, : )
END FUNCTION st_diffusionMatrix_C
END INTERFACE

INTERFACE DiffusionMatrix
  MODULE PROCEDURE Space_DiffusionMatrix, Space_DiffusionMatrix_K,&
    & Space_DiffusionMatrix_C, &
    & st_DiffusionMatrix, st_DiffusionMatrix_K,&
    & st_DiffusionMatrix_C
END INTERFACE DiffusionMatrix

PUBLIC :: DiffusionMatrix

!----------------------------------------------------------------------------
!                                            StiffnessMatrix@StiffnessMatrix
!----------------------------------------------------------------------------

INTERFACE
MODULE PURE FUNCTION Space_StiffnessMatrix_Cijkl( Test, Trial, Cijkl ) &
  & RESULT( Ans )
  CLASS( ElemshapeData_ ), INTENT( IN ) :: Test, Trial
  CLASS( FEVariable_ ), INTENT( IN ) :: Cijkl
  REAL( DFP ), ALLOCATABLE :: Ans( :, : )
END FUNCTION Space_StiffnessMatrix_Cijkl
END INTERFACE

INTERFACE StiffnessMatrix
  MODULE PROCEDURE Space_StiffnessMatrix_Cijkl
END INTERFACE StiffnessMatrix

PUBLIC :: StiffnessMatrix

!----------------------------------------------------------------------------
!                                            StiffnessMatrix@StiffnessMatrix
!----------------------------------------------------------------------------

INTERFACE
MODULE PURE FUNCTION Space_StiffnessMatrix_Lambda( Test, Trial, Lambda, Mu ) &
  & RESULT( Ans )
  CLASS( ElemshapeData_ ), INTENT( IN ) :: Test, Trial
  CLASS( FEVariable_ ), INTENT( IN ) :: Lambda, Mu
  REAL( DFP ), ALLOCATABLE :: Ans( :, : )
END FUNCTION Space_StiffnessMatrix_Lambda
END INTERFACE

INTERFACE StiffnessMatrix
  MODULE PROCEDURE Space_StiffnessMatrix_Lambda
END INTERFACE StiffnessMatrix

!----------------------------------------------------------------------------
!                                            StiffnessMatrix@StiffnessMatrix
!----------------------------------------------------------------------------

INTERFACE
MODULE PURE FUNCTION Space_StiffnessMatrix_LamMu( Test, Trial, Lambda,  &
  & Mu) RESULT( Ans )
  CLASS( ElemshapeData_ ), INTENT( IN ) :: Test, Trial
  REAL( DFP ), INTENT( IN ) :: Lambda, Mu
  REAL( DFP ), ALLOCATABLE :: Ans( :, : )
END FUNCTION Space_StiffnessMatrix_LamMu
END INTERFACE

INTERFACE StiffnessMatrix
  MODULE PROCEDURE Space_StiffnessMatrix_LamMu
END INTERFACE StiffnessMatrix

!----------------------------------------------------------------------------
!                                                NitscheMatrix@NitscheMatrix
!----------------------------------------------------------------------------

INTERFACE
MODULE PURE FUNCTION space_nitsche_mat_1( Test, Trial, Lambda, Mu, Evec ) &
  & RESULT( Ans )
  CLASS( ElemshapeData_ ), INTENT( IN ) :: Test, Trial
  CLASS( FEVariable_ ), INTENT( IN ) :: Lambda, Mu, Evec
  REAL( DFP ), ALLOCATABLE :: Ans( :, : )
END FUNCTION space_nitsche_mat_1
END INTERFACE

INTERFACE
MODULE PURE FUNCTION space_nitsche_mat_3( Test, Trial, Lambda, Mu, Evec ) &
  & RESULT( Ans )
  CLASS( ElemshapeData_ ), INTENT( IN ) :: Test, Trial
  CLASS( FEVariable_ ), INTENT( IN ) :: Evec
  REAL( DFP ), INTENT( IN ) :: Lambda, Mu
  REAL( DFP ), ALLOCATABLE :: Ans( :, : )
END FUNCTION space_nitsche_mat_3
END INTERFACE

INTERFACE
MODULE PURE FUNCTION space_nitsche_mat_5( Test, Trial, Lambda, Mu, isNoSlip)&
  & RESULT( Ans )
  CLASS( ElemshapeData_ ), INTENT( IN ) :: Test, Trial
  REAL( DFP ), INTENT( IN ) :: Lambda, Mu
  LOGICAL( LGT ), INTENT( IN ) :: isNoSlip
  REAL( DFP ), ALLOCATABLE :: Ans( :, : )
END FUNCTION space_nitsche_mat_5
END INTERFACE

INTERFACE
MODULE PURE FUNCTION space_nitsche_mat_7( Test, Trial, Lambda, Mu, isNoSlip )&
  & RESULT( Ans )
  CLASS( ElemshapeData_ ), INTENT( IN ) :: Test, Trial
  CLASS( FEVariable_ ), INTENT( IN ) :: Lambda, Mu
  LOGICAL( LGT ), INTENT( IN ) :: isNoSlip
  REAL( DFP ), ALLOCATABLE :: Ans( :, : )
END FUNCTION space_nitsche_mat_7
END INTERFACE

INTERFACE
MODULE PURE FUNCTION space_nitsche_mat_2( Test, Trial, Alpha, Evec ) &
  & RESULT( Ans )
  CLASS( ElemshapeData_ ), INTENT( IN ) :: Test, Trial
  CLASS( FEVariable_ ), INTENT( IN ) :: Alpha, Evec
  REAL( DFP ), ALLOCATABLE :: Ans( :, : )
END FUNCTION space_nitsche_mat_2
END INTERFACE

INTERFACE
MODULE PURE FUNCTION space_nitsche_mat_4( Test, Trial, Alpha, Evec ) &
  & RESULT( Ans )
  CLASS( ElemshapeData_ ), INTENT( IN ) :: Test, Trial
  CLASS( FEVariable_ ), INTENT( IN ) :: Evec
  REAL( DFP ), INTENT( IN ) :: Alpha
  REAL( DFP ), ALLOCATABLE :: Ans( :, : )
END FUNCTION space_nitsche_mat_4
END INTERFACE

INTERFACE NitscheMatrix
  MODULE PROCEDURE space_nitsche_mat_1, space_nitsche_mat_2, &
    & space_nitsche_mat_3, space_nitsche_mat_4, space_nitsche_mat_5, &
    & space_nitsche_mat_7
END INTERFACE NitscheMatrix

PUBLIC :: NitscheMatrix

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

END MODULE FEMatrix_Module