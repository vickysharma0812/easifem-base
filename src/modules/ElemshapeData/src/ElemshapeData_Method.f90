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

!> authors: Vikas Sharma, Ph. D.
! date: 1 March 2021
! summary: This module implements methods related to [[elemShapeData_]] datatype

MODULE ElemshapeData_Method
USE BaseType
USE GlobalData
IMPLICIT NONE
PRIVATE

!----------------------------------------------------------------------------
!                                                       Initiate@Constructor
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	4 March 2021
! summary: This subroutine allocate the memory for various matrices in the object
!
!### Introduction
! 	This subroutine allocates the memory for various matrices in the object. This subroutine belongs to the generic interface called `AllocateData()`.
!
!
!### Usage
!
!```fortran
!
!```

INTERFACE
MODULE PURE SUBROUTINE initiate_obj( obj, nsd, xidim, nns, nips )
  CLASS( ElemshapeData_ ), INTENT( INOUT ) :: obj
    !! object to be returned
  INTEGER( I4B ), INTENT( IN ) :: nsd
    !! spatial dimension
  INTEGER( I4B ), INTENT( IN ) :: xidim
    !! xidimension
  INTEGER( I4B ), INTENT( IN ) :: nns
    !! number of nodes in element
  INTEGER( I4B ), INTENT( IN ) :: nips
    !! number of integration points
END SUBROUTINE initiate_obj
END INTERFACE

INTERFACE AllocateData
  MODULE PROCEDURE initiate_obj
END INTERFACE AllocateData

PUBLIC :: AllocateData


!----------------------------------------------------------------------------
!                                                       Initiate@Constructor
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	4 March 2021
! summary: This subroutine initiate time shape function data in [[stelemshapedata_]]
!
!### Introduction
!
! * This subroutine initiate the time shape function data in [[stelemshapedata_]].
! * For the effeciency purpose, user should supply an instance of [[Elemshapedata_]] on time element. This object will have information of location time shape function data such as `T, dTdtheta` etc.
! * This routine uses `elemsd` to  set `obj%T`, `obj%dTdTheta`, `obj%Jt`, `obj%Wt`, `obj%Theta`.
! * The following examples shows how to use it.
!
!### Usage
!
!```fortran
!
!```

INTERFACE
MODULE PURE SUBROUTINE stsd_initiate( obj, elemsd )
  TYPE( STElemShapeData_ ), ALLOCATABLE, INTENT( INOUT ) :: obj( : )
  TYPE( ElemShapeData_ ), INTENT( IN ) :: elemsd
    !! It has information about location shape function for time element
END SUBROUTINE stsd_initiate
END INTERFACE

INTERFACE Initiate
  MODULE PROCEDURE stsd_initiate
END INTERFACE Initiate

PUBLIC :: Initiate

!----------------------------------------------------------------------------
!                                                 DeallocateData@Constructor
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	4 March 2021
! summary: This subroutine deallocates the data stored inside [[elemshapedata_]]
!
!### Introduction
! 	This routine deallocates the data stored inside [[elemshapedata_]]. This routine belongs to `AllocateData()`
!
!
!### Usage
!
!```fortran
!
!```

INTERFACE
MODULE PURE SUBROUTINE deallocate_data( obj )
  CLASS( ElemshapeData_ ), INTENT( INOUT ) :: obj
END SUBROUTINE deallocate_data
END INTERFACE

INTERFACE DeallocateData
    MODULE PROCEDURE deallocate_data
END INTERFACE DeallocateData

PUBLIC :: DeallocateData

!----------------------------------------------------------------------------
!                                                                Display@IO
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	4 March 2021
! summary: This subroutine display the content of [[elemshapedata_]] and [[stelemshapedata_]]
!
!### Introduction
! 	This subroutine displays the content of [[elemshapedata_]] and [[stelemshapedata_]] on screen. this routine belongs to `Display()`.
!
!### Usage
!
!```fortran
!
!```

INTERFACE
MODULE SUBROUTINE display_obj( obj, Msg, UnitNo )
  CLASS( ElemshapeData_ ), INTENT( IN ) :: obj
  CHARACTER( LEN = * ), INTENT( IN ) :: Msg
  INTEGER( I4B ), INTENT( IN ), OPTIONAL :: UnitNo
END SUBROUTINE display_obj
END INTERFACE

INTERFACE Display
  MODULE PROCEDURE display_obj
END INTERFACE Display

PUBLIC :: Display

!----------------------------------------------------------------------------
!                                                     setThickness@setMethod
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	4 March
! summary: This subroutine set the thickness field
!
!### Introduction
!
! This subroutine set the `thickness` field
! Here `Val` denotes the nodal value of thickeness
!
! $$d = d_{I} N^{I}$$
!
!### Usage
!
!```fortran
!
!```

INTERFACE
MODULE PURE SUBROUTINE set_thickness( obj, Val, N )
  CLASS( ElemshapeData_ ), INTENT( INOUT ) :: obj
  REAL( DFP ), INTENT( IN ) :: Val( : )
    !! Nodal values of thickness
  REAL( DFP ), INTENT( IN ) :: N( :, : )
    !! Shape function values at quadrature points
END SUBROUTINE set_thickness
END INTERFACE

!----------------------------------------------------------------------------
!                                                     setThickness@setMethod
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	4 March 2021
! summary: This subroutine set the thickness field
!
!### Introduction
!
! This subroutine set the `thickness` field
! Here `Val` denotes the space-time nodal value of thickeness
!
! $$d = d_{I}^{a} N^{I} T_{a}$$

INTERFACE
MODULE PURE SUBROUTINE stsd_set_thickness( obj, Val, N, T )
  CLASS( STElemshapeData_ ), INTENT( INOUT ) :: obj
  REAL( DFP ), INTENT( IN ) :: Val( :, : )
    !! Space-time nodal values of thickness
  REAL( DFP ), INTENT( IN ) :: N(:,:)
    !! Shape function at spatial quadrature
  REAL( DFP ), INTENT( IN ) :: T(:)
    !! Shape function at temporal quadrature
END SUBROUTINE stsd_set_thickness
END INTERFACE

INTERFACE setThickness
  MODULE PROCEDURE set_thickness, stsd_set_thickness
END INTERFACE

PUBLIC :: setThickness

!----------------------------------------------------------------------------
!                                              setBarycentricCoord@setMethod
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	4 March 2021
! summary: This subroutine set the Barycentric coordinates
!
!### Introduction
!
! This subroutine set the barycentric coordinates
!
! $$x_i = x_{iI} N^{I}$$
!
!### Usage
!
!```fortran
!
!```

INTERFACE
MODULE PURE SUBROUTINE set_coord( obj, Val, N )
  CLASS( ElemshapeData_ ), INTENT( INOUT ) :: obj
  REAL( DFP ), INTENT( IN ) :: Val( :, : )
    !! Nodal coordinates in `xiJ` format
  REAL( DFP ), INTENT( IN ) :: N(:,:)
    !! When element is not an isoparametric we can supply N.
END SUBROUTINE set_coord
END INTERFACE

!----------------------------------------------------------------------------
!                                              setBarycentricCoord@setMethod
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	4 March 2021
! summary: This subroutine set the Barycentric coordinates
!
!### Introduction
!
! This subroutine set the barycentric coordinates by using
! space-time nodal coordinates
!
! $$x=x_{I}^{a} N^I T_a$$

INTERFACE
MODULE PURE SUBROUTINE stsd_set_coord( obj, Val, N, T )
  CLASS( STElemshapeData_ ), INTENT( INOUT ) :: obj
  REAL( DFP ), INTENT( IN ) :: Val( :, :, : )
    !! space-time Nodal coordinates in `xiJ` format
  REAL( DFP ), INTENT( IN ) :: N( :, : ), T( : )
    !! N and T are required to handle non isoparametric elements
END SUBROUTINE stsd_set_coord
END INTERFACE

INTERFACE setBarycentricCoord
  MODULE PROCEDURE set_coord, stsd_set_coord
END INTERFACE setBarycentricCoord

PUBLIC :: setBarycentricCoord

!----------------------------------------------------------------------------
!                                                            setJs@setMethod
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 4 March 2021
! summary: This subroutine set the determinent of jacobian

INTERFACE
MODULE PURE SUBROUTINE set_Js( obj )
  CLASS( ElemShapeData_ ), INTENT( INOUT ) :: obj
END SUBROUTINE set_Js
END INTERFACE

INTERFACE setJs
  MODULE PROCEDURE set_Js
END INTERFACE setJs

PUBLIC setJs

!----------------------------------------------------------------------------
!                                                          setdNdXt@setMethod
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 4 March 2021
! summary: This subroutine set $\frac{d N}{d X_t}$ internally
!
!### Introduction
!
! This subroutine will internally set `dNdXt`.
! It use the inverse of jacobian stored internally, so make sure jacobian is
! set before calling this  subroutine.

INTERFACE
MODULE PURE SUBROUTINE set_dNdXt_internally( obj )
  CLASS( ElemshapeData_ ), INTENT( INOUT ) :: obj
END SUBROUTINE set_dNdXt_internally
END INTERFACE

INTERFACE setdNdXt
  MODULE PROCEDURE set_dNdXt_internally
END INTERFACE setdNdXt

PUBLIC :: setdNdXt

!----------------------------------------------------------------------------
!                                                      setJacobian@setMethod
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 4 March 2021
! summary: This subroutine set the jacobian
!
!### Introduction
!
! This subroutine set the jacobian by using the nodal coordinates
!
! $$\frac{d x_i}{d \xi_j} = x_{iI}\frac{d N^I}{d \xi_j}$$

INTERFACE
MODULE PURE SUBROUTINE set_jacobian( obj, Val, dNdXi )
  CLASS( ElemshapeData_ ), INTENT( INOUT ) :: obj
  REAL( DFP ), INTENT( IN ) :: Val( :, : )
    !! nodal coordinates in `xiJ` format
  REAL( DFP ), INTENT( IN ) :: dNdXi( :, :, : )
END SUBROUTINE set_jacobian
END INTERFACE

!----------------------------------------------------------------------------
!                                                      setJacobian@setMethod
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 4 March 2021
! summary: This subroutine set the jacobian using space-time nodal coords
!
!### Introduction
!
! This subroutine set the jacobian by using space-time nodal coords, `dNdXi`
! `T` are used to handle non-isoparameteric elements.
!
! $$\frac{d x_i}{d \xi_j} = x_{iI}^{a}T_a\frac{d N^I}{d \xi_j}$$
!
!### Usage
!
!```fortran
!
!```

INTERFACE
MODULE PURE SUBROUTINE stsd_set_jacobian( obj, Val, dNdXi, T )
  CLASS( STElemshapeData_ ), INTENT( INOUT ) :: obj
  REAL( DFP ), INTENT( IN ) :: Val( :, :, : )
    !! Space time nodal values of coordinates
  REAL( DFP ), INTENT( IN ) :: dNdXi(:,:,:)
    !! Local derivative of shape function for geometry
  REAL( DFP ), INTENT( IN ) :: T(:)
    !! Shape function for time element
END SUBROUTINE stsd_set_jacobian
END INTERFACE

INTERFACE setJacobian
  MODULE PROCEDURE set_jacobian, stsd_set_jacobian
END INTERFACE setJacobian

PUBLIC :: setJacobian

!----------------------------------------------------------------------------
!                                                         setdNTdt@setMethod
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 4 March 2021
! summary: This subroutine set `dNTdt` by using the space-time nodal values
!
!### Introduction
!
! - This subroutine set `dNTdt` by using space-time nodal values
! - It is important to note that `dNTdXt` should be allocated before calling
! - This subroutine uses following formula
!
! $$\frac{\partial N^{I\  }T_{a}}{\partial t} =N^{I}\frac{\partial T_{a}}
! {\partial \theta } J^{-1}_{t}-\frac{\partial N^{I}T_{a}}{\partial x_{k}}
! \hat{v}_{k} $$

INTERFACE
MODULE PURE SUBROUTINE stsd_set_dNTdt( obj, Val )
  CLASS( STElemShapeData_ ), INTENT( INOUT) :: obj
  REAL( DFP ), INTENT( IN ) :: Val( :, :, : )
    !! Space-time nodal values
END SUBROUTINE stsd_set_dNTdt
END INTERFACE

INTERFACE setdNTdt
  MODULE PROCEDURE stsd_set_dNTdt
END INTERFACE setdNTdt

PUBLIC :: setdNTdt

!----------------------------------------------------------------------------
!                                                        setdNTdXt@setMethod
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 4 March 2021
! summary: This subroutine set `dNTdXt` by using internal data
!
!### Introduction
!
! * This subroutine set `dNTdXt` by using internal data
! * This subroutine uses inverse of Jacobian, therefore, before calling
! * this subroutine make sure to set jacobian
!
! $$\frac{\partial N^{I\  }T_{a}}{\partial x_{i\  }}
! =\frac{\partial N^{I}T_{a}}{\partial \xi_{j} } \frac{\partial \xi_{j} }
! {\partial x_{i}} $$
!
!### Usage
!
!```fortran
!
!```

INTERFACE
MODULE PURE SUBROUTINE stsd_set_dNTdXt_internally( obj )
  CLASS( STElemShapeData_ ), INTENT( INOUT) :: obj
  !! Space-time nodal values
END SUBROUTINE stsd_set_dNTdXt_internally
END INTERFACE

INTERFACE setdNTdXt
  MODULE PROCEDURE stsd_set_dNTdXt_internally
END INTERFACE setdNTdXt

PUBLIC :: setdNTdXt

!----------------------------------------------------------------------------
!                                                         setValue@setMethod
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 4 March 2021
! summary: This subroutine set parameters defined on physical element
!
!### Introduction
!
! This subroutine set parameters defined on physical element
!
! * `Val` denotes nodal coordinates of element in `xiJ` format
! * This subroutine will call
!     - `setJacobian`
!     - `setJs`
!     - `setdNdXt`
!     - `setBarycentricCoord`
! * The facility of `N` and `dNdXi` allow us to handle non-isoparametric
! elements
!
!@note
! In case `obj` is instance of [[stelemshapedata_]] then `val` will denotes
! coordinates of spatial nodes at some time in [tn, tn+1]
!@endnote

INTERFACE
MODULE PURE SUBROUTINE set_value( obj, Val, N, dNdXi )
  CLASS( ElemshapeData_ ), INTENT( INOUT ) :: obj
  REAL( DFP ), INTENT( IN ) :: Val( :, : )
    !! Spatial nodal coordinates
  REAL( DFP ), INTENT( IN ) :: N(:, :)
    !! Shape function for geometry
  REAL( DFP ), INTENT( IN ) :: dNdXi( :, :, : )
    !! Local derivative of shape functions for geometry
END SUBROUTINE set_value
END INTERFACE

!----------------------------------------------------------------------------
!                                                         setValue@setMethod
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 4 March 2021
! summary: This subroutine set parameters defined on physical element
!
!### Introduction
!
! This subroutine set parameters defined on physical element
!
! * `Val` denotes coordinates of the space-time element in `xiJa` format
! * The facility of supplying `N`, `T`, and `dNdXi` allows us to handle
! non-isoparametric element
! * This subroutine will call
!     - `setJacobian` uses `dNdXi`
!     - `setJs`
!     - `setdNdXt`
!     - `setBarycentricCoord` uses `N` and `T`
!     - `setdNTdXt`
!     - `setdNTdt`
!
!@note
! In case of [[stelemshapedata_]] `val` denotes nodal coordinate at
! some intermediate space-time slab
!@endnote

INTERFACE
MODULE PURE SUBROUTINE stsd_set_value( obj, Val, N, T, dNdXi )
  CLASS( STElemshapeData_ ), INTENT( INOUT ) :: obj
  REAL( DFP ), INTENT( IN ) :: Val( :, :, : )
    !! Spatial nodal coordinates
  REAL( DFP ), INTENT( IN ) :: N( :, : )
  REAL( DFP ), INTENT( IN ) :: T( : )
  REAL( DFP ), INTENT( IN ) :: dNdXi( :, :, : )
END SUBROUTINE stsd_set_value
END INTERFACE

INTERFACE setValue
  MODULE PROCEDURE set_value, stsd_set_value
END INTERFACE setValue

PUBLIC :: setValue

!----------------------------------------------------------------------------
!                                                       setNormal@setMethod
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 4 March 2021
! summary: This subroutine sets the normal vector
!
!
!### Usage
!
!```fortran
!
!```

INTERFACE
MODULE PURE SUBROUTINE set_normal( obj )
  CLASS( ElemShapeData_ ), INTENT( INOUT) :: obj
END SUBROUTINE set_normal
END INTERFACE

INTERFACE setNormal
  MODULE PROCEDURE set_normal
END INTERFACE setNormal

PUBLIC :: setNormal

!----------------------------------------------------------------------------
!                                                 getInterpolation@getMethod
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 4 March 2021
! summary: This subroutine performs interpolations
!
!### Introduction
!
! This subroutine performs interpolation of a scalar from its spatial nodal
! values.
!
! $$u=u_{I}N^{I}$$
!
!### Usage
!
!```fortran
!
!```

INTERFACE
MODULE PURE SUBROUTINE get_interpol_scalar( obj, Interpol, Val )
  CLASS( ElemshapeData_ ), INTENT( IN ) :: obj
  REAL( DFP ), INTENT( INOUT ), ALLOCATABLE :: Interpol( : )
    !! Interpolation value of `val` at integration points
  REAL( DFP ), INTENT( IN ) :: Val( : )
    !! spatial nodal values of scalar
END SUBROUTINE get_interpol_scalar
END INTERFACE

!----------------------------------------------------------------------------
!                                                getInterpolation@getMethod
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 4 March 2021
! summary: T
INTERFACE
MODULE PURE SUBROUTINE get_interpol_fevar_scalar( obj, Interpol, Val )
  CLASS(ElemShapeData_), INTENT( IN ) :: obj
  TYPE( FEVariable_ ), INTENT( IN ) :: Val
  REAL( DFP ), INTENT(INOUT) :: Interpol(:)
END SUBROUTINE get_interpol_fevar_scalar
END INTERFACE

!----------------------------------------------------------------------------
!                                                 getInterpolation@getMethod
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 4 March 2021
! summary: This subroutine performs interpolation of a vector
!
!### Introduction
!
! This subroutine performs interpolation of a vector from its spatial
! nodal values
!
! $$u_{i}=u_{iI}N^{I}$$

INTERFACE
MODULE PURE SUBROUTINE get_interpol_vector( obj, Interpol, Val )
  CLASS( ElemshapeData_ ), INTENT( IN ) :: obj
  REAL( DFP ), INTENT( INOUT ), ALLOCATABLE :: Interpol( :, : )
    !! Interpol(:,ips) => interpolation value at integration points
  REAL( DFP ), INTENT( IN ) :: Val( :, : )
    !! nodal values of vector in `xiJ` format
END SUBROUTINE get_interpol_vector
END INTERFACE

!----------------------------------------------------------------------------
!                                                 getInterpolation@getMethod
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 4 March 2021
! summary: This subroutine performs interpolation of matrix
!
!### Introduction
! This subroutine performs interpolation of matrix
!
!### Usage
!
!```fortran
!
!```

INTERFACE
MODULE PURE SUBROUTINE get_interpol_matrix( obj, Interpol, Val )
  CLASS( ElemshapeData_ ), INTENT( IN ) :: obj
  REAL( DFP ), INTENT( INOUT ), ALLOCATABLE :: Interpol( :, :, : )
  REAL( DFP ), INTENT( IN ) :: Val( :, :, : )
    !! nodal value of matrix
END SUBROUTINE get_interpol_matrix
END INTERFACE

!----------------------------------------------------------------------------
!                                                 getInterpolation@getMethod
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 4 March 2021
! summary: This subroutine performs interpolation of matrix
!
! This subroutine performs interpolation of matrix

INTERFACE
MODULE PURE SUBROUTINE get_interpol_fevar_matrix( obj, Interpol, Val )
  CLASS( ElemshapeData_ ), INTENT( IN ) :: obj
  REAL( DFP ), INTENT( INOUT ) :: Interpol( :, :, : )
  TYPE( FEVariable_), INTENT( IN ) :: Val
END SUBROUTINE get_interpol_fevar_matrix
END INTERFACE

INTERFACE getInterpolation
  MODULE PROCEDURE get_interpol_scalar, get_interpol_vector, &
    & get_interpol_matrix, get_interpol_fevar_scalar, &
    & get_interpol_fevar_matrix
END INTERFACE getInterpolation

PUBLIC :: getInterpolation

!----------------------------------------------------------------------------
!                                                    Interpolation@getMethod
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 4 March 2021
! summary: This function returns the interpolation of a scalar
!
!### Introduction
!
! This function returns interpolation of scalar

INTERFACE
MODULE PURE FUNCTION interpol_scalar( obj, Val ) RESULT( Interpol )
  CLASS( ElemshapeData_ ), INTENT( IN ) :: obj
  REAL( DFP ), INTENT( IN ) :: Val( : )
  REAL( DFP ), ALLOCATABLE :: Interpol( : )
END FUNCTION interpol_scalar
END INTERFACE

!----------------------------------------------------------------------------
!                                                    Interpolation@getMethod
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 4 March 2021
! summary: This function returns the interpolation of vector
!
!### Introduction
!
! This function returns the interpolation of vectors
!
!### Usage
!
!```fortran
!
!```

INTERFACE
MODULE PURE FUNCTION interpol_vector( obj, Val ) RESULT( Interpol )
  CLASS( ElemshapeData_ ), INTENT( IN ) :: obj
  REAL( DFP ), INTENT( IN ) :: Val( :, : )
  REAL( DFP ), ALLOCATABLE :: Interpol( :, : )
END FUNCTION interpol_vector
END INTERFACE

!----------------------------------------------------------------------------
!                                                    Interpolation@getMethod
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 4 March 2021
! summary: This function returns the interpolation of matrix
!
!### Introduction
!
! This function returns the interpolation of matrix
!
!### Usage
!
!```fortran
!
!```

INTERFACE
MODULE PURE FUNCTION interpol_matrix( obj, Val ) RESULT( Interpol )
  CLASS( ElemshapeData_ ), INTENT( IN ) :: obj
  REAL( DFP ), INTENT( IN ) :: Val( :, :, : )
  REAL( DFP ), ALLOCATABLE :: Interpol( :, :, : )
END FUNCTION interpol_matrix
END INTERFACE

INTERFACE Interpolation
  MODULE PROCEDURE interpol_scalar, interpol_vector, interpol_matrix
END INTERFACE Interpolation

PUBLIC :: Interpolation

!----------------------------------------------------------------------------
!                                               getSTInterpolation@getMethod
!----------------------------------------------------------------------------

INTERFACE
!! This subroutine performs interpolations of scalar

!> authors: Dr. Vikas Sharma
!
! This subroutine performs interpolation of a scalar from its space-time nodal
! values.
! $$u=u^{a}_{I}N^{I}T_{a}$$
MODULE PURE SUBROUTINE stsd_get_interpol_scalar( obj, Interpol, Val )
  CLASS( STElemshapeData_ ), INTENT( IN ) :: obj
  REAL( DFP ), INTENT( INOUT ), ALLOCATABLE :: Interpol( : )
    !! Interpolation value of `val` at integration points
  REAL( DFP ), INTENT( IN ) :: Val( :, : )
    !! spatial nodal values of scalar
END SUBROUTINE stsd_get_interpol_scalar
END INTERFACE

!----------------------------------------------------------------------------
!                                                getInterpolation@getMethod
!----------------------------------------------------------------------------

INTERFACE
MODULE PURE SUBROUTINE stsd_get_interpol_fevar_scalar( obj, Interpol, Val )
  CLASS(STElemShapeData_), INTENT( IN ) :: obj( : )
  TYPE( FEVariable_ ), INTENT( IN ) :: Val
  REAL( DFP ), INTENT(INOUT) :: Interpol(:, :)
END SUBROUTINE stsd_get_interpol_fevar_scalar
END INTERFACE

!----------------------------------------------------------------------------
!                                               getSTInterpolation@getMethod
!----------------------------------------------------------------------------

INTERFACE
!! This subroutine performs interpolation of a vector

!> authors: Dr. Vikas Sharma
!
! This subroutine performs interpolation of a vector from its space-time
! nodal values
!
! $$u_{i}=u^{a}_{iI}N^{I}T_{a}$$
MODULE PURE SUBROUTINE stsd_get_interpol_vector( obj, Interpol, Val )
  CLASS( STElemshapeData_ ), INTENT( IN ) :: obj
  REAL( DFP ), INTENT( INOUT ), ALLOCATABLE :: Interpol( :, : )
    !! Interpol(:,ips) => interpolation value at integration points
  REAL( DFP ), INTENT( IN ) :: Val( :, :, : )
    !! space-time nodal values of vector in `xiJa` format
END SUBROUTINE stsd_get_interpol_vector
END INTERFACE

!----------------------------------------------------------------------------
!                                               getSTInterpolation@getMethod
!----------------------------------------------------------------------------

INTERFACE
!! This subroutine performs interpolation of matrix

!> authors: Dr. Vikas Sharma
!
! This subroutine performs interpolation of matrix from its space-time
! nodal values
MODULE PURE SUBROUTINE stsd_get_interpol_matrix( obj, Interpol, Val )
  CLASS( STElemshapeData_ ), INTENT( IN ) :: obj
  REAL( DFP ), INTENT( INOUT ), ALLOCATABLE :: Interpol( :, :, : )
  REAL( DFP ), INTENT( IN ) :: Val( :, :, :, : )
    !! nodal value of matrix
END SUBROUTINE stsd_get_interpol_matrix
END INTERFACE

!----------------------------------------------------------------------------
!                                                getInterpolation@getMethod
!----------------------------------------------------------------------------

INTERFACE
MODULE PURE SUBROUTINE stsd_get_interpol_fevar_matrix( obj, Interpol, Val )
  CLASS(STElemShapeData_), INTENT( IN ) :: obj( : )
  TYPE( FEVariable_ ), INTENT( IN ) :: Val
  REAL( DFP ), INTENT(INOUT) :: Interpol(:, :, :, :)
END SUBROUTINE stsd_get_interpol_fevar_matrix
END INTERFACE

!----------------------------------------------------------------------------
!
!----------------------------------------------------------------------------

INTERFACE getInterpolation
  MODULE PROCEDURE stsd_get_interpol_scalar, stsd_get_interpol_vector, &
    & stsd_get_interpol_matrix, stsd_get_interpol_fevar_scalar, &
    & stsd_get_interpol_fevar_matrix
END INTERFACE getInterpolation

!----------------------------------------------------------------------------
!                                                 STInterpolation@getMethod
!----------------------------------------------------------------------------

INTERFACE
!! This function performs interpolations of scalar

!> authors: Dr. Vikas Sharma
!
! This function performs interpolation of a scalar from its space-time nodal
! values.
! $$u=u^{a}_{I}N^{I}T_{a}$$
MODULE PURE FUNCTION stsd_interpol_scalar( obj, Val ) RESULT(interpol)
  CLASS( STElemshapeData_ ), INTENT( IN ) :: obj
  REAL( DFP ), INTENT( IN ) :: Val( :, : )
    !! space-time nodal values of scalar
  REAL( DFP ), ALLOCATABLE :: Interpol( : )
    !! Interpolation value of `val` at integration points
END FUNCTION stsd_interpol_scalar
END INTERFACE

!----------------------------------------------------------------------------
!                                                 STInterpolation@getMethod
!----------------------------------------------------------------------------

INTERFACE
!! This function performs interpolations of vector

!> authors: Dr. Vikas Sharma
!
! This function performs interpolation of a vector from its space-time nodal
! values.
! $$u=u^{a}_{I}N^{I}T_{a}$$

MODULE PURE FUNCTION stsd_interpol_vector( obj, Val ) RESULT(interpol)
  CLASS( STElemshapeData_ ), INTENT( IN ) :: obj
  REAL( DFP ), INTENT( IN ) :: Val( :, :, : )
    !! spatial nodal values of vector
  REAL( DFP ), ALLOCATABLE :: Interpol( :, : )
    !! Interpolation value of `val` at integration points
END FUNCTION stsd_interpol_vector
END INTERFACE

!----------------------------------------------------------------------------
!                                                 STInterpolation@getMethod
!----------------------------------------------------------------------------

INTERFACE
!! This function performs interpolations of matrix

!> authors: Dr. Vikas Sharma
!
! This function performs interpolation of a matrix from its space-time nodal
! values.
! $$u=u^{a}_{I}N^{I}T_{a}$$

MODULE PURE FUNCTION stsd_interpol_matrix( obj, Val ) RESULT(interpol)
  CLASS( STElemshapeData_ ), INTENT( IN ) :: obj
  REAL( DFP ), INTENT( IN ) :: Val( :, :, :, : )
    !! spatial nodal values of matrix
  REAL( DFP ), ALLOCATABLE :: Interpol( :, :, : )
    !! Interpolation value of `val` at integration points
END FUNCTION stsd_interpol_matrix
END INTERFACE

INTERFACE STInterpolation
  MODULE PROCEDURE stsd_interpol_scalar, stsd_interpol_vector, &
    & stsd_interpol_matrix
END INTERFACE STInterpolation

!----------------------------------------------------------------------------
!                                                 getLocalGradient@getMethod
!----------------------------------------------------------------------------

INTERFACE
!! This subroutine returns the local gradient of a scalar

!> authors: Dr. Vikas Sharma
!
! This subroutine returns the local gradient of a scalar from space
! nodal values
!
! $$\frac{\partial \phi }{\partial \xi_{i} } =\phi_{I} \frac{\partial N^{I}}
! {\partial \xi_{i} }$$

MODULE PURE SUBROUTINE getLocalGradient_scalar( obj, dPhidXi, Val )
  CLASS( ElemShapeData_ ), INTENT( IN ) :: obj
  REAL( DFP ), ALLOCATABLE, INTENT( INOUT ) :: dPhidXi( :, : )
  REAL( DFP ), INTENT( IN ) :: Val( : )
    !! Space nodal values of scalar
END SUBROUTINE getLocalGradient_scalar
END INTERFACE

!----------------------------------------------------------------------------
!                                                 getLocalGradient@getMethod
!----------------------------------------------------------------------------

INTERFACE
!! This subroutine returns the local gradient of a vector

!> authors: Dr. Vikas Sharma
!
! This subroutine returns the local gradient of a vector
MODULE PURE SUBROUTINE getLocalGradient_vector( obj, dVdXi, Val )
  CLASS( ElemshapeData_ ), INTENT( IN ) :: obj
  REAL( DFP ), ALLOCATABLE, INTENT( INOUT ) :: dVdXi( :, :, : )
    !! local gradient at integration points
  REAL( DFP ), INTENT( IN ) :: Val( :, : )
    !! nodal values of vector in `xiJ` format
END SUBROUTINE getLocalGradient_vector
END INTERFACE

!----------------------------------------------------------------------------
!                                                 getLocalGradient@getMethod
!----------------------------------------------------------------------------

INTERFACE
!! This subroutine returns the local gradient of a scalar

!> authors: Dr. Vikas Sharma
!
! This subroutine returns the local gradient of a scalar from space
! time nodal values
!
! $$\frac{\partial \phi }{\partial \xi_{i} } =\phi^{a}_{I} T_{a}\frac
!{\partial N^{I}}{\partial \xi_{i} }$$
MODULE PURE SUBROUTINE stsd_getLocalGradient_scalar( obj, dPhidXi, Val )
  CLASS( STElemShapeData_ ), INTENT( IN ) :: obj
  REAL( DFP ), ALLOCATABLE, INTENT( INOUT ) :: dPhidXi( :, : )
    !! local gradient of scalar
  REAL( DFP ), INTENT( IN ) :: Val( :, : )
    !! space-time nodal values
END SUBROUTINE stsd_getLocalGradient_scalar
END INTERFACE

!----------------------------------------------------------------------------
!                                                 getLocalGradient@getMethod
!----------------------------------------------------------------------------

INTERFACE
!! This subroutine returns the local gradient of a vector

!> authors: Dr. Vikas Sharma
!
! This subroutine returns the local gradient of a vector using space-time
! nodal coordinates
MODULE PURE SUBROUTINE stsd_getLocalGradient_vector( obj, dVdXi, Val )
  CLASS( STElemshapeData_ ), INTENT( IN ) :: obj
  REAL( DFP ), ALLOCATABLE, INTENT( INOUT ) :: dVdXi( :, :, : )
    !! local gradient at integration points
  REAL( DFP ), INTENT( IN ) :: Val( :, :, : )
    !! space-time nodal values of vector in `xiJa` format
END SUBROUTINE stsd_getLocalGradient_vector
END INTERFACE

!----------------------------------------------------------------------------
!                                                           getLocalGradient
!----------------------------------------------------------------------------
INTERFACE getLocalGradient
  MODULE PROCEDURE getLocalGradient_scalar, getLocalGradient_vector, &
    & stsd_getLocalGradient_scalar, stsd_getLocalGradient_vector
END INTERFACE getLocalGradient

! PUBLIC :: getLocalGradient/

!----------------------------------------------------------------------------
!                                               getSpatialGradient@getMethod
!----------------------------------------------------------------------------

INTERFACE
!! This subroutine returns the spatial gradient of vector

!> authors: Dr. Vikas Sharma
!
! This subroutine returns the spatial gradient of a vector
MODULE PURE SUBROUTINE getSpatialGradient_vector( obj, dVdXt, Val )
  CLASS( ElemshapeData_ ), INTENT( IN ) :: obj
  REAL( DFP ), ALLOCATABLE, INTENT( INOUT ) :: dVdXt( :, :, : )
    !! spatial gradient of `val` at integration points
  REAL( DFP ), INTENT( IN ) :: Val( :, : )
    !! nodal values of vector in `xiJ` format
END SUBROUTINE getSpatialGradient_vector
END INTERFACE

!----------------------------------------------------------------------------
!                                               getSpatialGradient@getMethod
!----------------------------------------------------------------------------

INTERFACE
!! This subroutine returns the spatial gradient of scalar

!> authors: Dr. Vikas Sharma
!
! This subroutine returns the spatial gradient of scalar
MODULE PURE SUBROUTINE getSpatialGradient_scalar( obj, dPhidXt, Val )
  CLASS( ElemShapeData_ ), INTENT( IN ) :: obj
  REAL( DFP ), ALLOCATABLE, INTENT( INOUT ) :: dPhidXt( :, : )
    !! Spatial gradient of scalar
  REAL( DFP ), INTENT( IN ) :: Val( : )
    !! Nodal values of scalar
END SUBROUTINE getSpatialGradient_scalar
END INTERFACE

!----------------------------------------------------------------------------
!                                               getSpatialGradient@getMethod
!----------------------------------------------------------------------------

INTERFACE
!! This subroutine returns the spatial gradient of scalar

!> authors: Dr. Vikas Sharma
!
! This subroutine returns the spatial gradient of scalar
MODULE PURE SUBROUTINE stsd_getSpatialGradient_scalar( obj, dPhidXt, Val )
  CLASS( STElemShapeData_ ), INTENT( IN ) :: obj
  REAL( DFP ), ALLOCATABLE, INTENT( INOUT ) :: dPhidXt( :, : )
    !! Spatial gradient of scalar
  REAL( DFP ), INTENT( IN ) :: Val( :, : )
    !! space-time Nodal values of scalar
END SUBROUTINE stsd_getSpatialGradient_scalar
END INTERFACE

!----------------------------------------------------------------------------
!                                               getSpatialGradient@getMethod
!----------------------------------------------------------------------------

INTERFACE
!! This subroutine returns the spatial gradient of vector

!> authors: Dr. Vikas Sharma
!
! This subroutine returns the spatial gradient of a vector from its
! space-time nodal values
MODULE PURE SUBROUTINE stsd_getSpatialGradient_vector( obj, dVdXt, Val )
  CLASS( STElemshapeData_ ), INTENT( IN ) :: obj
  REAL( DFP ), ALLOCATABLE, INTENT( INOUT ) :: dVdXt( :, :, : )
    !! spatial gradient of `val` at integration points
  REAL( DFP ), INTENT( IN ) :: Val( :, :, : )
    !! space-time nodal values of vector in `xiJa` format
END SUBROUTINE stsd_getSpatialGradient_vector
END INTERFACE

INTERFACE getSpatialGradient
  MODULE PROCEDURE getSpatialGradient_scalar, getSpatialGradient_vector, &
    & stsd_getSpatialGradient_scalar, &
      & stsd_getSpatialGradient_vector
END INTERFACE getSpatialGradient

PUBLIC :: getSpatialGradient

!----------------------------------------------------------------------------
!                                            getProjectionOfdNdXt@getMethod
!----------------------------------------------------------------------------

INTERFACE
!! This subroutine computes the projection of dNdXt on a vector

!> authors: Dr. Vikas Sharma
!
! This subroutine computes the projcetion cdNdXt on the vector `Val`
! Here the vector `Val` is constant in space and time
!
! $$P^{I}=c_{i}\frac{\partial N^{I}}{\partial x_{i}} $$
!
MODULE PURE SUBROUTINE getProjectionOfdNdXt_spacevalues( obj, cdNdXt, Val )
  CLASS( ElemshapeData_ ), INTENT( IN ) :: obj
  REAL( DFP ), ALLOCATABLE, INTENT( INOUT ) :: cdNdXt( :, : )
    !! returned $c_{i}\frac{\partial N^{I}}{\partial x_{i}}$
  REAL( DFP ), INTENT( IN ) :: Val( : )
    !! constant value of vector
END SUBROUTINE getProjectionOfdNdXt_spacevalues
END INTERFACE

!----------------------------------------------------------------------------
!                                            getProjectionOfdNdXt@getMethod
!----------------------------------------------------------------------------

INTERFACE
!! This subroutine computes the projection of dNdXt on a vector

!> authors: Dr. Vikas Sharma
!
! This subroutine computes the projcetion cdNdXt on the vector `Val`
! Here the vector `Val` is constant in space and time
!
! $$P^{I}=c_{i}\frac{\partial N^{I}}{\partial x_{i}} $$
!
MODULE PURE SUBROUTINE getProjectionOfdNdXt_fevar( obj, cdNdXt, Val )
  CLASS( ElemshapeData_ ), INTENT( IN ) :: obj
  REAL( DFP ), ALLOCATABLE, INTENT( INOUT ) :: cdNdXt( :, : )
    !! returned $c_{i}\frac{\partial N^{I}}{\partial x_{i}}$
  CLASS( FEVariable_ ), INTENT( IN ) :: Val
    !! constant value of vector
END SUBROUTINE getProjectionOfdNdXt_fevar
END INTERFACE

INTERFACE getProjectionOfdNdXt
  MODULE PROCEDURE &
    & getProjectionOfdNdXt_spacevalues,&
    & getProjectionOfdNdXt_fevar
END INTERFACE getProjectionOfdNdXt

PUBLIC :: getProjectionOfdNdXt

!----------------------------------------------------------------------------
!                                            getProjectionOfdNTdXt@getMethod
!----------------------------------------------------------------------------

INTERFACE
!! This subroutine computes the projection of dNTdXt on a vector

!> authors: Dr. Vikas Sharma
!
! This subroutine computes the projcetion cdNTdXt on the vector `Val`
! Here the vector `Val` is constant in space and time
!
! $$P^{I,a}=c_{i}\frac{\partial N^{I} T_a}{\partial x_{i}}$$
!
MODULE PURE SUBROUTINE getProjectionOfdNTdXt_constvector( obj, cdNTdXt, Val )
  CLASS( STElemshapeData_ ), INTENT( IN ) :: obj
  REAL( DFP ), ALLOCATABLE, INTENT( INOUT ) :: cdNTdXt( :, :, : )
    !! returned $c_{i}\frac{\partial N^{I} T_a}{\partial x_{i}}$
  REAL( DFP ), INTENT( IN ) :: Val( : )
    !! constant value of vector
END SUBROUTINE getProjectionOfdNTdXt_constvector
END INTERFACE

!----------------------------------------------------------------------------
!                                            getProjectionOfdNTdXt@getMethod
!----------------------------------------------------------------------------

INTERFACE
!! This subroutine computes the projection of dNTdXt on a vector

!> authors: Dr. Vikas Sharma
!
! This subroutine computes the projcetion cdNTdXt on the vector `Val`
! Here the vector `Val` is constant in space and time
!
! $$P^{I,a}=c_{i}\frac{\partial N^{I} T_a}{\partial x_{i}}$$
!
MODULE PURE SUBROUTINE getProjectionOfdNTdXt_fevar( obj, cdNTdXt, Val )
  CLASS( STElemshapeData_ ), INTENT( IN ) :: obj
  REAL( DFP ), ALLOCATABLE, INTENT( INOUT ) :: cdNTdXt( :, :, : )
    !! returned $c_{i}\frac{\partial N^{I} T_a}{\partial x_{i}}$
  TYPE( FEVariable_ ), INTENT( IN ) :: Val
    !! constant value of vector
END SUBROUTINE getProjectionOfdNTdXt_fevar
END INTERFACE

!----------------------------------------------------------------------------
!                                            getProjectionOfdNTdXt@getMethod
!----------------------------------------------------------------------------

INTERFACE getProjectionOfdNTdXt
  MODULE PROCEDURE &
    & getProjectionOfdNTdXt_constvector, &
    & getProjectionOfdNTdXt_fevar
END INTERFACE getProjectionOfdNTdXt

PUBLIC :: getProjectionOfdNTdXt

!----------------------------------------------------------------------------
!                                                    getUnitNormal@getMethod
!----------------------------------------------------------------------------

INTERFACE
!! This subroutine can be used in SUPG formulation

!> authors: Dr. Vikas Sharma
!
! This routine can be used in the SUPG formulation
!
!  $$\nabla \vert phi \vert / \vert (\nabla \vert phi \vert) \vert$$
!

MODULE PURE SUBROUTINE getUnitNormal_scalar( obj, R, Val )
  CLASS( ElemshapeData_ ), INTENT( IN ) :: obj
  REAL( DFP ), ALLOCATABLE, INTENT( INOUT ) :: R( :, : )
  REAL( DFP ), INTENT( IN ) :: Val( : )
END SUBROUTINE getUnitNormal_scalar
END INTERFACE

!----------------------------------------------------------------------------
!                                                    getUnitNormal@getMethod
!----------------------------------------------------------------------------

INTERFACE
MODULE PURE SUBROUTINE getUnitNormal_vector( obj, R, Val )
  CLASS( ElemshapeData_ ), INTENT( INOUT ) :: obj
  REAL( DFP ), ALLOCATABLE, INTENT( INOUT  ) :: R( :, : )
  REAL( DFP ), INTENT( IN ) :: Val( :, : )
END SUBROUTINE getUnitNormal_vector
END INTERFACE

INTERFACE getUnitNormal
  MODULE PROCEDURE getUnitNormal_vector, getUnitNormal_scalar
END INTERFACE getUnitNormal

PUBLIC :: getUnitNormal

!----------------------------------------------------------------------------
!                                                        Initiate@H1Lagrange
!----------------------------------------------------------------------------

INTERFACE
MODULE PURE SUBROUTINE H1_Lagrange( obj, Quad, RefElem, &
  & ContinuityType, InterpolType )
  CLASS( ElemshapeData_ ), INTENT( INOUT ) :: obj
  CLASS( QuadraturePoint_ ), INTENT( IN ) :: Quad
  CLASS( ReferenceElement_ ), INTENT( IN ) :: RefElem
  CLASS( H1_ ), INTENT( IN ) :: ContinuityType
  CLASS( LagrangeInterpolation_ ), INTENT( IN ) :: InterpolType
END SUBROUTINE H1_Lagrange
END INTERFACE

INTERFACE Initiate
  MODULE PROCEDURE H1_Lagrange
END INTERFACE Initiate

!----------------------------------------------------------------------------
!                                                                   Contains
!----------------------------------------------------------------------------

END MODULE ElemshapeData_Method