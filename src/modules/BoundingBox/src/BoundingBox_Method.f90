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
! date: 	23 Feb 2021
! summary: [[BoundingBox_Method]] module consists method for data type [[BoundingBox_]]
!
!### Introduction
! This module consists method for data type [[BoundingBox_]]. These methods are included in following submoudles:
!- `BoundingBox_Method@Constructor`
!

MODULE BoundingBox_Method
USE GlobalData, ONLY: DFP, I4B, LGT, stdout
USE BaseType, ONLY: BoundingBox_
IMPLICIT NONE

PRIVATE

!----------------------------------------------------------------------------
!                                                        Initiate@Constructor
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: 	This function initiatea an instance of [[BoundingBox_]].
!
!### Introduction
! This function initiates an instance of [[BoundingBox_]].
!- `NSD` is the spatial dimension
!- `lim` is vector of real numbers (length=6)
!- `lim(1)` => xmin
!- `lim(2)` => ymin
!- `lim(3)` => zmin
!- `lim(4)` => xmax
!- `lim(5)` => ymax
!- `lim(6)` => zmax
!
!### Usage
!```fortran
! subroutine test
!   type(BoundingBox_) :: obj
!   call initiate( obj, nsd = 2, lim=[0.0_DFP, 1.0_DFP, 0.0_DFP, 1.0_DFP, 0.0_DFP, 0.0_DFP] )
!   call display( obj, msg="test1" )
! end subroutine test
!```

INTERFACE
MODULE PURE SUBROUTINE initiate_1( Obj, nsd, lim )
  CLASS( BoundingBox_ ), INTENT( INOUT ) :: Obj
    !! Instance of bounding box
  INTEGER( I4B ), INTENT( IN ) :: NSD
    !! Spatial dimension
  REAL( DFP ), INTENT( IN ) :: lim( 6 )
    !! Extent of bounding box
END SUBROUTINE initiate_1
END INTERFACE

!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: Initiate the instance of [[BoundingBox_]] from the another box
!
!### Introduction
!
! This subroutine initiate the instance of [[BoundingBox_]] from another instance. It is basically a copy command.
!
!### Usage
!
!```fortran
! subroutine test2
!   type(BoundingBox_) :: obj, obj2
!   call initiate( obj, 2, [0.0_DFP, 1.0_DFP, 0.0_DFP, 1.0_DFP, 0.0_DFP, 0.0_DFP] )
!   call initiate(obj2, obj)
!   call display( obj2, msg="test2")
! end subroutine test2
!```


INTERFACE
MODULE PURE SUBROUTINE initiate_2( Obj, AnotherObj )
    CLASS( BoundingBox_ ), INTENT( INOUT) :: Obj
    CLASS( BoundingBox_ ), INTENT( IN) :: AnotherObj
END SUBROUTINE initiate_2
END INTERFACE

INTERFACE Initiate
    MODULE PROCEDURE initiate_1, initiate_2
END INTERFACE Initiate

PUBLIC :: Initiate

!----------------------------------------------------------------------------
!                                                     BoundingBox@Constructor
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: 	Function to create [[BoundingBox_]] instance
!
!### Introduction
! This function initiates an instance of [[BoundingBox_]].
!- `NSD` is the spatial dimension
!- `lim` is vector of real numbers (length=6)
!- `lim(1)` => xmin
!- `lim(2)` => ymin
!- `lim(3)` => zmin
!- `lim(4)` => xmax
!- `lim(5)` => ymax
!- `lim(6)` => zmax
!
!### Usage
!```fortran
! subroutine test3
!   type(BoundingBox_) :: obj
!   obj = BoundingBox( nsd = 2, lim=[0.0_DFP, 1.0_DFP, 0.0_DFP, 1.0_DFP, 0.0_DFP, 0.0_DFP] )
!   call display( obj, msg="test1" )
! end subroutine test3
!```

INTERFACE
MODULE PURE FUNCTION Constructor1( nsd, lim ) RESULT( Ans )
    TYPE( BoundingBox_ ) :: Ans
    INTEGER( I4B ), INTENT( IN ) :: nsd
    REAL( DFP ), INTENT( IN ) :: lim( 6 )
END FUNCTION Constructor1
END INTERFACE

!----------------------------------------------------------------------------
!                                                     BoundingBox@Constructor
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: 	This function creates an instance of [[BoundingBox_]]
!
!### Introduction
!This function creates an intance of [[BoundingBox_]].
!
!### Usage
!```fortran
! subroutine test4
!   type(BoundingBox_) :: obj, obj2
!   call initiate( obj, 2, [0.0_DFP, 1.0_DFP, 0.0_DFP, 1.0_DFP, 0.0_DFP, 0.0_DFP] )
!   obj2 = BoundingBox(obj)
!   call display( obj2, msg="test2")
! end subroutine test4
!```

INTERFACE
MODULE PURE FUNCTION Constructor2( AnotherObj ) RESULT( Ans )
    TYPE( BoundingBox_ ) :: Ans
    CLASS( BoundingBox_ ), INTENT( IN ) :: AnotherObj
END FUNCTION Constructor2
END INTERFACE

!----------------------------------------------------------------------------
!                                                                BoundingBox
!----------------------------------------------------------------------------

INTERFACE
!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: 	This function creates an instance of [[BoundingBox_]]
!
!### Introduction
! This function creates an instance of [[BoundingBox_]]. In this function NSD is determined from SIZE(xij, 1).
!
!### Usage
!```fortran
! subroutine test5
!   type(BoundingBox_) :: obj
!   obj = boundingBox(RESHAPE([0.0_DFP, 1.0_DFP, 0.0_DFP, 1.0_DFP, 0.0_DFP, 0.0_DFP], [2,3]))
!   call display(obj, "test5")
! end subroutine test5
!```

MODULE PURE FUNCTION Constructor3( xij ) RESULT( Ans )
  REAL( DFP ), INTENT( IN ) :: xij( :, : )
    !! Nodal coordinates xij( 1:nsd, 1:tnodes )
  TYPE( BoundingBox_ ) :: Ans
    !!
END FUNCTION Constructor3
END INTERFACE

!----------------------------------------------------------------------------
!                                                                 BoundingBox
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: 	Generic function to create Bounding box
!
!### Introduction
! This is a generic function to create the instance of [[BoundingBox_]]. Following interfaces are avaiables:
!
!```fortran
!obj=boundingBox(nsd, lim)
!obj=boundingBox(anotherobj)
!obj=boundingBox(xij)
!```

INTERFACE BoundingBox
    MODULE PROCEDURE Constructor1, Constructor2, Constructor3
END INTERFACE BoundingBox

PUBLIC :: BoundingBox

!----------------------------------------------------------------------------
!                                             BoundingBox_Pointer@Constructor
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: 	This function returns the pointer to [[BoundingBox_]] instance
!
!### Introduction
!
! This function returns the pointer to [[BoundingBox_]] instance.
!- `NSD` is the spatial dimension
!- `lim` is vector of real numbers (length=6)
!- `lim(1)` => xmin
!- `lim(2)` => ymin
!- `lim(3)` => zmin
!- `lim(4)` => xmax
!- `lim(5)` => ymax
!- `lim(6)` => zmax
!
!### Usage
!
!```fortran
! subroutine test6
!   type(BoundingBox_) :: obj
!   type(BoundingBox_), pointer :: obj2

!   call initiate( obj, 2, [0.0_DFP, 1.0_DFP, 0.0_DFP, 1.0_DFP, 0.0_DFP, 0.0_DFP] )
!   obj2 => BoundingBox_Pointer(obj)
!   call display( obj2, msg="test6")
! end subroutine test6
!```

INTERFACE
MODULE FUNCTION Constructor_1( nsd, lim ) RESULT( Ans )
    CLASS( BoundingBox_ ), POINTER :: Ans
    INTEGER( I4B ), INTENT( IN ) :: nsd
    REAL( DFP ), INTENT( IN ) :: lim( 6 )
END FUNCTION Constructor_1
END INTERFACE

!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: 	This function returns the pointer to an instance of [[BoundingBox_]]
!
!### Introduction
! This function returns the pointer to an instance of [[BoundingBox_]] by copying contents from `AnotherObj`
!
!### Usage
!```fortran
! subroutine test7
!   type(BoundingBox_), pointer :: obj
!   obj => BoundingBox_Pointer(nsd=3, lim=[0.0_DFP, 1.0_DFP, 0.0_DFP, 1.0_DFP, 0.0_DFP, 0.0_DFP])
!   call display(obj, "test7")
! end subroutine test7
!```


INTERFACE
MODULE FUNCTION Constructor_2( AnotherObj ) RESULT( Ans )
    CLASS( BoundingBox_ ), POINTER :: Ans
    CLASS( BoundingBox_ ), INTENT( IN ) :: AnotherObj
END FUNCTION Constructor_2
END INTERFACE

INTERFACE BoundingBox_Pointer
    MODULE PROCEDURE Constructor_1, Constructor_2
END INTERFACE BoundingBox_Pointer

PUBLIC :: BoundingBox_Pointer

!----------------------------------------------------------------------------
!                                                        Display@Constructor
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: 	This subroutine displays the content of [[BoundingBox_]]

INTERFACE
MODULE SUBROUTINE display_obj( Obj, msg, unitno )
    CLASS( BoundingBox_ ), INTENT( IN ) :: Obj
    CHARACTER( LEN = * ), INTENT( IN ) :: msg
    INTEGER( I4B ), OPTIONAL, INTENT( IN ) :: unitNo
END SUBROUTINE display_obj
END INTERFACE

INTERFACE Display
    MODULE PROCEDURE display_obj
END INTERFACE Display

PUBLIC :: Display

!----------------------------------------------------------------------------
!                                                         setXmin@setMethods
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 23 Feb 2021
! summary: 	This subroutine set the Xmin in bounding box

INTERFACE
MODULE PURE SUBROUTINE setXmin( Obj, Val )
    CLASS( BoundingBox_ ), INTENT( INOUT ) :: Obj
    REAL( DFP ), INTENT( IN ) :: Val
END SUBROUTINE setXmin
END INTERFACE

!----------------------------------------------------------------------------
!                                                         setXmax@setMethods
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: 	This subroutine set the Xmax in bounding box

INTERFACE
MODULE PURE SUBROUTINE setXmax( Obj, Val )
    CLASS( BoundingBox_ ), INTENT( INOUT ) :: Obj
    REAL( DFP ), INTENT( IN ) :: Val
END SUBROUTINE setXmax
END INTERFACE

!----------------------------------------------------------------------------
!                                                         setYmin@setMethods
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: 	This subroutine set the Ymin in bounding box

INTERFACE
MODULE PURE SUBROUTINE setYmin( Obj, Val )
    CLASS( BoundingBox_ ), INTENT( INOUT ) :: Obj
    REAL( DFP ), INTENT( IN ) :: Val
END SUBROUTINE setYmin
END INTERFACE

!----------------------------------------------------------------------------
!                                                         setYmax@setMethods
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: 	This subroutine set the Ymax of bounding box

INTERFACE
MODULE PURE SUBROUTINE setYmax( Obj, Val )
    CLASS( BoundingBox_ ), INTENT( INOUT ) :: Obj
    REAL( DFP ), INTENT( IN ) :: Val
END SUBROUTINE setYmax
END INTERFACE

!----------------------------------------------------------------------------
!                                                         setZmin@setMethods
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: 	This subroutine set the Zmin of bounding box

INTERFACE
MODULE PURE SUBROUTINE setZmin( Obj, Val )
    CLASS( BoundingBox_ ), INTENT( INOUT ) :: Obj
    REAL( DFP ), INTENT( IN ) :: Val
END SUBROUTINE setZmin
END INTERFACE

!----------------------------------------------------------------------------
!                                                         setZmax@setMethods
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: 	This subroutine set the Zmax of bounding box

INTERFACE
MODULE PURE SUBROUTINE setZmax( Obj, Val )
    CLASS( BoundingBox_ ), INTENT( INOUT ) :: Obj
    REAL( DFP ), INTENT( IN ) :: Val
END SUBROUTINE setZmax
END INTERFACE

!----------------------------------------------------------------------------
!                                                         getXmin@getMethods
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: 	This function returns the xmin
!
!### Usage
!
!```fortran
! xmin = .xmin. obj
!```

INTERFACE
MODULE PURE FUNCTION getXmin( Obj ) RESULT( Ans )
    CLASS( BoundingBox_ ), INTENT( IN ) :: Obj
    REAL( DFP ) :: Ans
END FUNCTION getXmin
END INTERFACE

INTERFACE Operator( .Xmin. )
  MODULE PROCEDURE getXmin
END INTERFACE Operator( .Xmin. )

PUBLIC :: Operator( .Xmin. )

!----------------------------------------------------------------------------
!                                                         getXmax@getMethods
!----------------------------------------------------------------------------


!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: 	This function returns the xmax
!
!### Usage
!
!```fortran
! xmax = .xmax. obj
!```

INTERFACE
MODULE PURE FUNCTION getXmax( Obj ) RESULT( Ans )
    CLASS( BoundingBox_ ), INTENT( IN ) :: Obj
    REAL( DFP ) :: Ans
END FUNCTION getXmax
END INTERFACE

INTERFACE Operator( .Xmax. )
    MODULE PROCEDURE getXmax
END INTERFACE Operator( .Xmax. )

PUBLIC :: Operator( .Xmax. )

!----------------------------------------------------------------------------
!                                                         getYmin@getMethods
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: 	This function returns the ymin
!
!### Usage
!
!```fortran
! ymin = .ymin. obj
!```

INTERFACE
MODULE PURE FUNCTION getYmin( Obj ) RESULT( Ans )
    CLASS( BoundingBox_ ), INTENT( IN ) :: Obj
    REAL( DFP ) :: Ans
END FUNCTION getYmin
END INTERFACE

INTERFACE Operator( .Ymin. )
    MODULE PROCEDURE getYmin
END INTERFACE Operator( .Ymin. )

PUBLIC :: Operator( .Ymin. )

!----------------------------------------------------------------------------
!                                                         getYmax@getMethods
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: 	This function returns the ymax
!
!### Usage
!
!```fortran
! ymax = .ymax. obj
!```

INTERFACE
MODULE PURE FUNCTION getYmax( Obj ) RESULT( Ans )
    CLASS( BoundingBox_ ), INTENT( IN ) :: Obj
    REAL( DFP ) :: Ans
END FUNCTION getYmax
END INTERFACE

INTERFACE Operator( .Ymax. )
    MODULE PROCEDURE getYmax
END INTERFACE Operator( .Ymax. )

PUBLIC :: Operator( .Ymax. )

!----------------------------------------------------------------------------
!                                                         getZmin@getMethods
!----------------------------------------------------------------------------


!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: 	This function returns the zmin
!
!### Usage
!
!```fortran
! zmin = .zmin. obj
!```

INTERFACE
MODULE PURE FUNCTION getZmin( Obj ) RESULT( Ans )
  CLASS( BoundingBox_ ), INTENT( IN ) :: Obj
  REAL( DFP ) :: Ans
END FUNCTION getZmin
END INTERFACE

INTERFACE Operator( .Zmin. )
  MODULE PROCEDURE getZmin
END INTERFACE Operator( .Zmin. )

PUBLIC :: Operator( .Zmin. )

!----------------------------------------------------------------------------
!                                                         getZmax@getMethods
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: 	This function returns the zmax
!
!### Usage
!
!```fortran
! zmax = .zmax. obj
!```

INTERFACE
MODULE PURE FUNCTION getZmax( Obj ) RESULT( Ans )
  CLASS( BoundingBox_ ), INTENT( IN ) :: Obj
  REAL( DFP ) :: Ans
END FUNCTION getZmax
END INTERFACE

INTERFACE Operator( .Zmax. )
  MODULE PROCEDURE getZmax
END INTERFACE Operator( .Zmax. )

PUBLIC :: Operator( .Zmax. )

!----------------------------------------------------------------------------
!                                                  isIntersectInX@getMethods
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: 	This function checks if two bounding boxes interesect in x direction
!
!@todo
!### Usage
!@endtodo

INTERFACE
MODULE PURE FUNCTION is_intersect_in_X( Obj, Obj2 ) RESULT( Ans )
  CLASS( BoundingBox_ ), INTENT( IN ) :: Obj, Obj2
  LOGICAL( LGT ) :: Ans
END FUNCTION is_intersect_in_X
END INTERFACE

INTERFACE isIntersectInX
    MODULE PROCEDURE is_intersect_in_X
END INTERFACE isIntersectInX

PUBLIC :: isIntersectInX

!----------------------------------------------------------------------------
!                                                  isIntersectInY@getMethods
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: 	This function checks if two bounding boxes interesect in y direction
!
!@todo
!### Usage
!@endtodo

INTERFACE
MODULE PURE FUNCTION is_intersect_in_Y( Obj, Obj2 ) RESULT( Ans )
  CLASS( BoundingBox_ ), INTENT( IN ) :: Obj, Obj2
  LOGICAL( LGT ) :: Ans
END FUNCTION is_intersect_in_Y
END INTERFACE

INTERFACE isIntersectInY
    MODULE PROCEDURE is_intersect_in_Y
END INTERFACE isIntersectInY

PUBLIC :: isIntersectInY

!----------------------------------------------------------------------------
!                                                 isIntersectInZ@getMethods
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: 	This function checks if two bounding boxes interesect in z direction
!
!@todo
!### Usage
!@endtodo

INTERFACE
MODULE PURE FUNCTION is_intersect_in_Z( Obj, Obj2 ) RESULT( Ans )
  CLASS( BoundingBox_ ), INTENT( IN ) :: Obj, Obj2
  LOGICAL( LGT ) :: Ans
END FUNCTION is_intersect_in_Z
END INTERFACE

INTERFACE isIntersectInZ
  MODULE PROCEDURE is_intersect_in_Z
END INTERFACE isIntersectInZ

PUBLIC :: isIntersectInZ


!----------------------------------------------------------------------------
!                                                    isIntersect@getMethods
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: 	This function checks if two bounding boxes interesect each other
!
!@todo
!### Usage
!@endtodo

INTERFACE
MODULE PURE FUNCTION is_intersect( Obj, Obj2 ) RESULT( Ans )
  CLASS( BoundingBox_ ), INTENT( IN ) :: Obj, Obj2
  LOGICAL( LGT ) :: Ans
END FUNCTION is_intersect
END INTERFACE

INTERFACE Operator( .isIntersect. )
    MODULE PROCEDURE is_intersect
END INTERFACE Operator( .isIntersect. )

PUBLIC :: Operator( .isIntersect. )

INTERFACE isIntersect
  MODULE PROCEDURE is_intersect
END INTERFACE isIntersect

PUBLIC :: isIntersect

!----------------------------------------------------------------------------
!                                                  getIntersection@getMethod
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: 	This function returns the intersection bounding box of two bounding box
!
!### Introduction
! This function returns the bounding box which is formed by the intersection of two bounding box
!
!@todo
![] add usage
!@endtodo

INTERFACE
MODULE PURE FUNCTION get_intersection( Obj, Obj2 ) RESULT( Ans )
  CLASS( BoundingBox_ ), INTENT( IN ) :: Obj, Obj2
  TYPE( BoundingBox_ ) :: Ans
END FUNCTION get_intersection
END INTERFACE

INTERFACE OPERATOR( .Intersection. )
  MODULE PROCEDURE get_intersection
END INTERFACE OPERATOR( .Intersection. )

PUBLIC :: OPERATOR( .Intersection. )

INTERFACE Intersection
  MODULE PROCEDURE get_intersection
END INTERFACE Intersection

PUBLIC :: Intersection

!----------------------------------------------------------------------------
!                                                         getUnion@getMethod
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: 	This function returns the union of two bounding box
!
!### Introduction
! This function returns the bounding box which is formed by the union of two bounding box.
!
!@todo
![] add usage
!@endtodo

INTERFACE
MODULE PURE FUNCTION get_Union( Obj, Obj2 ) RESULT( Ans )
  CLASS( BoundingBox_ ), INTENT( IN ) :: Obj, Obj2
  TYPE( BoundingBox_ ) :: Ans
END FUNCTION get_Union
END INTERFACE

INTERFACE OPERATOR(.UNION.)
  MODULE PROCEDURE get_Union
END INTERFACE OPERATOR(.UNION.)

PUBLIC :: OPERATOR(.UNION.)

INTERFACE Union
  MODULE PROCEDURE get_Union
END INTERFACE Union

PUBLIC :: Union

!----------------------------------------------------------------------------
!                                                        getCenter@getMethod
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: 	This function returns the center of bounding box
!
!### Introduction
!
!This function returns the centern of bounding box.
!
!@todo
![] add usage
!@endtodo

INTERFACE
MODULE PURE FUNCTION get_Center( Obj ) RESULT( Ans )
  CLASS( BoundingBox_ ), INTENT( IN ) :: Obj
  REAL( DFP ) :: Ans( 3 )
END FUNCTION get_Center
END INTERFACE

INTERFACE Center
  MODULE PROCEDURE get_Center
END INTERFACE Center

PUBLIC :: Center

INTERFACE OPERATOR(.Center.)
  MODULE PROCEDURE get_Center
END INTERFACE OPERATOR(.Center.)

PUBLIC :: OPERATOR(.Center.)

!----------------------------------------------------------------------------
!                                                         isInside@getMethod
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: 	This function checks if a point is inside the bounding box or not
!
!### Introduction
!
! This function checks if a point is inside a bounding box or not
!
!@todo
![] add usage
!@endtodo

INTERFACE
MODULE PURE FUNCTION is_Inside( Obj, Val ) RESULT( Ans )
  CLASS( BoundingBox_ ), INTENT( IN ) :: Obj
  REAL( DFP ), INTENT( IN ) :: Val( : )
  LOGICAL( LGT ) :: Ans
END FUNCTION is_Inside
END INTERFACE

INTERFACE OPERATOR( .isInside. )
    MODULE PROCEDURE is_Inside
END INTERFACE OPERATOR( .isInside. )

PUBLIC :: OPERATOR( .isInside. )

INTERFACE isInside
    MODULE PROCEDURE is_Inside
END INTERFACE isInside

PUBLIC :: isInside

!----------------------------------------------------------------------------
!                                                         getNptrs@getMethod
!----------------------------------------------------------------------------

!> authors: Vikas Sharma, Ph. D.
! date: 	23 Feb 2021
! summary: 	This function returns the node numbers located inside the bounding box
!
!### Introduction
!
! This function returns the list of node numbers which are inside the bounding box
!
!@todo
![] usage
!@endtodo

INTERFACE
MODULE PURE FUNCTION get_nptrs( Obj, xij ) RESULT( Ans )
  CLASS( BoundingBox_ ), INTENT( IN ) :: Obj
  REAL( DFP ), INTENT( IN ) :: xij( :, : )
  INTEGER( I4B ), ALLOCATABLE :: Ans( : )
END FUNCTION get_nptrs
END INTERFACE

INTERFACE OPERATOR( .Nptrs. )
  MODULE PROCEDURE get_nptrs
END INTERFACE

PUBLIC :: OPERATOR( .Nptrs. )

END MODULE BoundingBox_Method
