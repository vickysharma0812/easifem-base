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
! date: 	28 Feb 2021
! summary: 	This submodule contains Input/Output methods for [[IntVector_]]

SUBMODULE( IntVector_Method ) IO
USE BaseMethod
IMPLICIT NONE
CONTAINS

!----------------------------------------------------------------------------
!                                                                    Display
!----------------------------------------------------------------------------

MODULE PROCEDURE intVec_Display1
  INTEGER( I4B ) :: j, I
  I = Input( option=UnitNo, default=stdout)
  CALL Display( msg = "# " // TRIM(msg), UnitNo = I )
  CALL Display( msg = "size : ", val = SIZE( obj ), unitNo = I )
  DO j = 1, SIZE( obj )
    CALL Display( obj( j ), msg = "( " // TRIM(STR( fm=FI4B, n=j )) // " ) ", &
      & unitNo = I )
  END DO
END PROCEDURE intVec_Display1

!----------------------------------------------------------------------------
!                                                                    Display
!----------------------------------------------------------------------------

MODULE PROCEDURE intVec_Display2
  INTEGER( I4B ) :: I
  I = Input( option=UnitNo, default=stdout)
  CALL Display( msg = "# " // TRIM(msg), UnitNo = I )
  CALL Display( msg = "size : ", val = SIZE( obj ), unitNo = I )
  CALL Display( Val = obj%Val, msg='', UnitNo=I, orient='col', full=.true. )
END PROCEDURE intVec_Display2

END SUBMODULE IO