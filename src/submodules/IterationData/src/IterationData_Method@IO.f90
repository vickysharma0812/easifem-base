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
SUBMODULE( IterationData_Method ) IO
USE BaseMethod
IMPLICIT NONE
CONTAINS

!----------------------------------------------------------------------------
!                                                                   Display
!----------------------------------------------------------------------------

MODULE PROCEDURE display_obj
  ! Define internal variables
  INTEGER( I4B ) :: I
  IF( PRESENT( UnitNo ) ) THEN
    I = UnitNo
  ELSE
    I = StdOut
  END IF
  IF( LEN_TRIM( msg ) .NE. 0 ) WRITE( I, "(A)" ) "#" // TRIM( msg )
  WRITE( I, "( A, L6 )" )    "Convergence: ", obj%Converged
  WRITE( I, "( A, I6 )" )    "Maximum Iteration: ", obj%MaxIter
  WRITE( I, "( A, I6 )" )    "Total Iteration Taken: ", obj%IterationNumber
  WRITE( I, "( A, G17.6 )" ) "Tolerance: ", obj%Tolerance
  WRITE( I, "( A, G17.6 )" ) "Error At Start: ", obj%ErrorAtStart
  WRITE( I, "( A, G17.6 )" ) "Error At End: ", obj%ErrorAtEnd
  WRITE( I, "( A, G17.6 )" ) "Time Taken: ", &
    & obj%TimeAtEnd - obj%TimeAtStart
END PROCEDURE display_obj

END SUBMODULE IO