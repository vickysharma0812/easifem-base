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
! date: 2 March 2021
! summary: 	This submodule contains methods for [[ReferenceTetrahedron_]]

SUBMODULE( ReferenceTetrahedron_Method ) Methods
USE BaseMethod
IMPLICIT NONE
CONTAINS

!----------------------------------------------------------------------------
!                                                                  Initiate
!----------------------------------------------------------------------------

MODULE PROCEDURE Initiate_ref_Tetrahedron
END PROCEDURE Initiate_ref_Tetrahedron

!----------------------------------------------------------------------------
!                                                      ReferenceTetrahedron
!----------------------------------------------------------------------------

MODULE PROCEDURE reference_Tetrahedron
  IF( PRESENT( XiJ ) ) THEN
    CALL Initiate( obj, NSD, XiJ )
  ELSE
    CALL Initiate( obj, NSD )
  END IF
END PROCEDURE reference_Tetrahedron

!----------------------------------------------------------------------------
!                                              ReferenceTetrahedron_Pointer
!----------------------------------------------------------------------------

MODULE PROCEDURE reference_Tetrahedron_Pointer
  ALLOCATE( obj )
  IF( PRESENT( XiJ ) ) THEN
    CALL Initiate( obj, NSD, XiJ )
  ELSE
    CALL Initiate( obj, NSD )
  END IF
END PROCEDURE reference_Tetrahedron_Pointer

!----------------------------------------------------------------------------
!                                                            LagrangePoints
!----------------------------------------------------------------------------

PURE FUNCTION EquidistanceLIP_Tetrahedron( XiJ, Order ) &
  & RESULT( NodeCoord )
  REAL( DFP ), INTENT( IN ) :: XiJ( 3, 4 )
  INTEGER( I4B ), INTENT( IN ) :: Order
  REAL( DFP ), ALLOCATABLE :: NodeCoord( :, : )

  SELECT CASE ( Order )
    CASE( 1 )
    !tetra4
    NodeCoord = reshape( [ &
      & 0.0, 0.0, 0.0, &
      & 1.0, 0.0, 0.0, &
      & 0.0, 1.0, 0.0, &
      & 0.0, 0.0, 1.0 ], [3, 4])

    CASE( 2 )
    ! tetra10
    NodeCoord = reshape( [ &
      & 0.0, 0.0, 0.0, &
      & 1.0, 0.0, 0.0, &
      & 0.0, 1.0, 0.0, &
      & 0.0, 0.0, 1.0, &
      & 0.5, 0.0, 0.0, &
      & 0.5, 0.5, 0.0, &
      & 0.0, 0.5, 0.0, &
      & 0.0, 0.0, 0.5, &
      & 0.0, 0.5, 0.5, &
      & 0.5, 0.0, 0.5 ], [3, 10])

    CASE( 3 )
    !tetra20
    NodeCoord = reshape( [ &
      & 0.0, 0.0, 0.0, &
      & 1.0, 0.0, 0.0, &
      & 0.0, 1.0, 0.0, &
      & 0.0, 0.0, 1.0, &
      & 0.33333333333333333333, 0.0, 0.0, &
      & 0.66666666666666666667, 0.0, 0.0, &
      & 0.66666666666666666667, 0.33333333333333333333, 0.0, &
      & 0.33333333333333333333, 0.66666666666666666667, 0.0, &
      & 0.0, 0.66666666666666666667, 0.0, &
      & 0.0, 0.33333333333333333333, 0.0, &
      & 0.0, 0.0, 0.66666666666666666667, &
      & 0.0, 0.0, 0.33333333333333333333, &
      & 0.0, 0.33333333333333333333, 0.66666666666666666667, &
      & 0.0, 0.66666666666666666667, 0.33333333333333333333, &
      & 0.33333333333333333333, 0.0, 0.66666666666666666667, &
      & 0.66666666666666666667, 0.0, 0.33333333333333333333, &
      & 0.33333333333333333333, 0.33333333333333333333, 0.0, &
      & 0.33333333333333333333, 0.0, 0.33333333333333333333, &
      & 0.0, 0.33333333333333333333, 0.33333333333333333333, &
      & 0.33333333333333333333, 0.33333333333333333333, 0.33333333333333333333], [3,20])

    CASE( 4 )
    !tetra35
    NodeCoord = reshape( [ &
      & 0.0, 0.0, 0.0, &
      & 1.0, 0.0, 0.0, &
      & 0.0, 1.0, 0.0, &
      & 0.0, 0.0, 1.0, &
      & 0.25, 0.0, 0.0, &
      & 0.5, 0.0, 0.0, &
      & 0.75, 0.0, 0.0, &
      & 0.75, 0.25, 0.0, &
      & 0.5, 0.5, 0.0, &
      & 0.25, 0.75, 0.0, &
      & 0.0, 0.75, 0.0, &
      & 0.0, 0.5, 0.0, &
      & 0.0, 0.25, 0.0, &
      & 0.0, 0.0, 0.75, &
      & 0.0, 0.0, 0.5, &
      & 0.0, 0.0, 0.25, &
      & 0.0, 0.25, 0.75, &
      & 0.0, 0.5, 0.5, &
      & 0.0, 0.75, 0.25, &
      & 0.25, 0.0, 0.75, &
      & 0.5, 0.0, 0.5, &
      & 0.75, 0.0, 0.25, &
      & 0.25, 0.25, 0.0, &
      & 0.25, 0.5, 0.0, &
      & 0.5, 0.25, 0.0, &
      & 0.25, 0.0, 0.25, &
      & 0.5, 0.0, 0.25, &
      & 0.25, 0.0, 0.5, &
      & 0.0, 0.25, 0.25, &
      & 0.0, 0.25, 0.5, &
      & 0.0, 0.5, 0.25, &
      & 0.25, 0.25, 0.5, &
      & 0.5, 0.25, 0.25, &
      & 0.25, 0.5, 0.25, &
      & 0.25, 0.25, 0.25 ], [3, 35])

    CASE( 5 )
    !tetra56
    NodeCoord = reshape( [ &
      & 0.0, 0.0, 0.0, &
      & 1.0, 0.0, 0.0, &
      & 0.0, 1.0, 0.0, &
      & 0.0, 0.0, 1.0, &
      & 0.2, 0.0, 0.0, &
      & 0.4, 0.0, 0.0, &
      & 0.6, 0.0, 0.0, &
      & 0.8, 0.0, 0.0, &
      & 0.8, 0.2, 0.0, &
      & 0.6, 0.4, 0.0, &
      & 0.4, 0.6, 0.0, &
      & 0.2, 0.8, 0.0, &
      & 0.0, 0.8, 0.0, &
      & 0.0, 0.6, 0.0, &
      & 0.0, 0.4, 0.0, &
      & 0.0, 0.2, 0.0, &
      & 0.0, 0.0, 0.8, &
      & 0.0, 0.0, 0.6, &
      & 0.0, 0.0, 0.4, &
      & 0.0, 0.0, 0.2, &
      & 0.0, 0.2, 0.8, &
      & 0.0, 0.4, 0.6, &
      & 0.0, 0.6, 0.4, &
      & 0.0, 0.8, 0.2, &
      & 0.2, 0.0, 0.8, &
      & 0.4, 0.0, 0.6, &
      & 0.6, 0.0, 0.4, &
      & 0.8, 0.0, 0.2, &
      & 0.2, 0.2, 0.0, &
      & 0.2, 0.6, 0.0, &
      & 0.6, 0.2, 0.0, &
      & 0.2, 0.4, 0.0, &
      & 0.4, 0.4, 0.0, &
      & 0.4, 0.2, 0.0, &
      & 0.2, 0.0, 0.2, &
      & 0.6, 0.0, 0.2, &
      & 0.2, 0.0, 0.6, &
      & 0.4, 0.0, 0.2, &
      & 0.4, 0.0, 0.4, &
      & 0.2, 0.0, 0.4, &
      & 0.0, 0.2, 0.2, &
      & 0.0, 0.2, 0.6, &
      & 0.0, 0.6, 0.2, &
      & 0.0, 0.2, 0.4, &
      & 0.0, 0.4, 0.4, &
      & 0.0, 0.4, 0.2, &
      & 0.2, 0.2, 0.6, &
      & 0.6, 0.2, 0.2, &
      & 0.2, 0.6, 0.2, &
      & 0.4, 0.2, 0.4, &
      & 0.4, 0.4, 0.2, &
      & 0.2, 0.4, 0.4, &
      & 0.2, 0.2, 0.2, &
      & 0.4, 0.2, 0.2, &
      & 0.2, 0.4, 0.2, &
      & 0.2, 0.2, 0.4 ], [3, 56])

    CASE( 6 )
    NodeCoord = reshape( [ &
      & 0.0, 0.0, 0.0, &
      & 1.0, 0.0, 0.0, &
      & 0.0, 1.0, 0.0, &
      & 0.0, 0.0, 1.0, &
      & 0.16666666666666666667, 0.0, 0.0, &
      & 0.33333333333333333333, 0.0, 0.0, &
      & 0.5, 0.0, 0.0, &
      & 0.66666666666666666667, 0.0, 0.0, &
      & 0.83333333333333333333, 0.0, 0.0, &
      & 0.83333333333333333333, 0.16666666666666666667, 0.0, &
      & 0.66666666666666666667, 0.33333333333333333333, 0.0, &
      & 0.5, 0.5, 0.0, &
      & 0.33333333333333333333, 0.66666666666666666667, 0.0, &
      & 0.16666666666666666667, 0.83333333333333333333, 0.0, &
      & 0.0, 0.83333333333333333333, 0.0, &
      & 0.0, 0.66666666666666666667, 0.0, &
      & 0.0, 0.5, 0.0, &
      & 0.0, 0.33333333333333333333, 0.0, &
      & 0.0, 0.16666666666666666667, 0.0, &
      & 0.0, 0.0, 0.83333333333333333333, &
      & 0.0, 0.0, 0.66666666666666666667, &
      & 0.0, 0.0, 0.5, &
      & 0.0, 0.0, 0.33333333333333333333, &
      & 0.0, 0.0, 0.16666666666666666667, &
      & 0.0, 0.16666666666666666667, 0.83333333333333333333, &
      & 0.0, 0.33333333333333333333, 0.66666666666666666667, &
      & 0.0, 0.5, 0.5, &
      & 0.0, 0.66666666666666666667, 0.33333333333333333333, &
      & 0.0, 0.83333333333333333333, 0.16666666666666666667, &
      & 0.16666666666666666667, 0.0, 0.83333333333333333333, &
      & 0.33333333333333333333, 0.0, 0.66666666666666666667, &
      & 0.5, 0.0, 0.5, &
      & 0.66666666666666666667, 0.0, 0.33333333333333333333, &
      & 0.83333333333333333333, 0.0, 0.16666666666666666667, &
      & 0.16666666666666666667, 0.16666666666666666667, 0.0, &
      & 0.16666666666666666667, 0.66666666666666666667, 0.0, &
      & 0.66666666666666666667, 0.16666666666666666667, 0.0, &
      & 0.16666666666666666667, 0.33333333333333333333, 0.0, &
      & 0.16666666666666666667, 0.5, 0.0, &
      & 0.33333333333333333333, 0.5, 0.0, &
      & 0.5, 0.33333333333333333333, 0.0, &
      & 0.5, 0.16666666666666666667, 0.0, &
      & 0.33333333333333333333, 0.16666666666666666667, 0.0, &
      & 0.33333333333333333333, 0.33333333333333333333, 0.0, &
      & 0.16666666666666666667, 0.0, 0.16666666666666666667, &
      & 0.66666666666666666667, 0.0, 0.16666666666666666667, &
      & 0.16666666666666666667, 0.0, 0.66666666666666666667, &
      & 0.33333333333333333333, 0.0, 0.16666666666666666667, &
      & 0.5, 0.0, 0.16666666666666666667, &
      & 0.5, 0.0, 0.33333333333333333333, &
      & 0.33333333333333333333, 0.0, 0.5, &
      & 0.16666666666666666667, 0.0, 0.5, &
      & 0.16666666666666666667, 0.0, 0.33333333333333333333, &
      & 0.33333333333333333333, 0.0, 0.33333333333333333333, &
      & 0.0, 0.16666666666666666667, 0.16666666666666666667, &
      & 0.0, 0.16666666666666666667, 0.66666666666666666667, &
      & 0.0, 0.66666666666666666667, 0.16666666666666666667, &
      & 0.0, 0.16666666666666666667, 0.33333333333333333333, &
      & 0.0, 0.16666666666666666667, 0.5, &
      & 0.0, 0.33333333333333333333, 0.5, &
      & 0.0, 0.5, 0.33333333333333333333, &
      & 0.0, 0.5, 0.16666666666666666667, &
      & 0.0, 0.33333333333333333333, 0.16666666666666666667, &
      & 0.0, 0.33333333333333333333, 0.33333333333333333333, &
      & 0.16666666666666666667, 0.16666666666666666667, 0.66666666666666666667, &
      & 0.66666666666666666667, 0.16666666666666666667, 0.16666666666666666667, &
      & 0.16666666666666666667, 0.66666666666666666667, 0.16666666666666666667, &
      & 0.33333333333333333333, 0.16666666666666666667, 0.5, &
      & 0.5, 0.16666666666666666667, 0.33333333333333333333, &
      & 0.5, 0.33333333333333333333, 0.16666666666666666667, &
      & 0.33333333333333333333, 0.5, 0.16666666666666666667, &
      & 0.16666666666666666667, 0.5, 0.33333333333333333333, &
      & 0.16666666666666666667, 0.33333333333333333333, 0.5, &
      & 0.33333333333333333333, 0.33333333333333333333, 0.33333333333333333333, &
      & 0.16666666666666666667, 0.16666666666666666667, 0.16666666666666666667, &
      & 0.5, 0.16666666666666666667, 0.16666666666666666667, &
      & 0.16666666666666666667, 0.5, 0.16666666666666666667, &
      & 0.16666666666666666667, 0.16666666666666666667, 0.5, &
      & 0.33333333333333333333, 0.16666666666666666667, 0.16666666666666666667, &
      & 0.33333333333333333333, 0.33333333333333333333, 0.16666666666666666667, &
      & 0.16666666666666666667, 0.33333333333333333333, 0.16666666666666666667, &
      & 0.16666666666666666667, 0.16666666666666666667, 0.33333333333333333333, &
      & 0.16666666666666666667, 0.33333333333333333333, 0.33333333333333333333, &
      & 0.33333333333333333333, 0.16666666666666666667, 0.33333333333333333333], [3, 84])
  END SELECT
END FUNCTION EquidistanceLIP_Tetrahedron

!----------------------------------------------------------------------------
!                                                             LagrangeElement
!----------------------------------------------------------------------------

MODULE PROCEDURE LagrangeElement_Tetrahedron
END PROCEDURE LagrangeElement_Tetrahedron

!----------------------------------------------------------------------------
!                                                              MeasureSimplex
!----------------------------------------------------------------------------

MODULE PROCEDURE Measure_Simplex_Tetrahedron
  CALL TETRAHEDRONVOLUME3D( XiJ( 1:3, 1:4 ), Ans )
END PROCEDURE Measure_Simplex_Tetrahedron

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

MODULE PROCEDURE Tetrahedron_quality
END PROCEDURE Tetrahedron_quality

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

#include "./modified_burkardt.inc"

END SUBMODULE Methods