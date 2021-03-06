! convert data to crs format

program main
  use easifem
  implicit none

    type( sparsematrix_ ) :: obj
    real( dfp ), allocatable :: mat( :, : )
    type( csc_ ) :: cscobj

    call initiate( obj = obj, tdof = 1, tnodes = [8], matrixProp = 'SYM' )
    call setsparsity( obj = obj, row = 1, col = [1,2    ] )
    call setsparsity( obj = obj, row = 2, col = [2, 1, 3] )
    call setsparsity( obj = obj, row = 3, col = [3, 2, 4] )
    call setsparsity( obj = obj, row = 4, col = [4, 3, 5] )
    call setsparsity( obj = obj, row = 5, col = [5, 4, 6] )
    call setsparsity( obj = obj, row = 6, col = [6,5,  7] )
    call setsparsity( obj = obj, row = 7, col = [7,6,  8] )
    call setsparsity( obj = obj, row = 8, col = [8,7    ] )

    mat = reshape( [1.0, -1.0, -1.0, 1.0], [2,2] )
    mat( 1, 2 ) =0.0; mat(2,1) = 0.0
    call addcontribution( obj, [1,2], mat, 1.0_dfp, na)
    mat = reshape( [1.0, -1.0, -1.0, 1.0], [2,2] )
    call addcontribution( obj, [2,3], mat, 1.0_dfp, na)
    call addcontribution( obj, [3,4], mat, 1.0_dfp, na)
    call addcontribution( obj, [4,5], mat, 1.0_dfp, na)
    call addcontribution( obj, [5,6], mat, 1.0_dfp, na)
    call addcontribution( obj, [6,7], mat, 1.0_dfp, na)
    call addcontribution( obj, [7,8], mat, 1.0_dfp, na)

    call convert( from = obj, to = cscobj )
    call convert( from = obj, to = mat )
    call  display( mat, "mat" )

    ! !dsdcg
    ! block
    !   INTEGER( I4B ) :: N, NELT, LENW, LENIW
    !   real( dfp ), allocatable :: sol( : ), rhs( : ), RWORK( :  ), sol0( : )
    !   INTEGER( I4B ) :: ISYM, ITOL, ITMAX, Iter, ierr
    !   INTEGER( I4B ), allocatable :: IWORK( : )
    !   REAL( DFP ) :: Tol, err

    !   N = cscobj%nrow
    !   NELT = SIZE( cscobj%A )
    !   LENW = 5*N+1
    !   LENIW = 11
    !   ISYM = 1
    !   ITOL = 1
    !   ITMAX = 8
    !   Tol = 1.0E-5

    !   allocate( sol( N ), rhs( N ), RWORK( LENW ), sol0( N ), IWORK( LENIW ) )
    !   call random_number( sol0 ); call display( sol0, 'sol0', stdout, .true. )
    !   rhs = matmul( mat, sol0 ); sol = 0.0;
    !   call dsdcg( N, rhs, sol, NELT, cscobj%IA, cscobj%JA, cscobj%A, &
    !     & ISYM, ITOL, TOL, ITMAX, ITER, ERR, IERR, stdout, RWORK, LENW, &
    !     & IWORK, LENIW )
    !   call display( sol, 'sol', stdout, .true. )
    !   call display( abs( sol - sol0 ), 'error', stdout, .true. )
    !   call display( ierr, "ierr")
    ! end block

    ! !dsiccg
    ! block
    !   INTEGER( I4B ) :: N, NELT, LENW, LENIW
    !   real( dfp ), allocatable :: sol( : ), rhs( : ), RWORK( :  ), sol0( : )
    !   INTEGER( I4B ) :: ISYM, ITOL, ITMAX, Iter, ierr
    !   INTEGER( I4B ), allocatable :: IWORK( : )
    !   REAL( DFP ) :: Tol, err

    !   N = cscobj%nrow
    !   NELT = SIZE( cscobj%A )
    !   LENW = 5*N + NELT + 1
    !   LENIW = NELT + N + 11 + 1
    !   ISYM = 1
    !   ITOL = 1
    !   ITMAX = 8
    !   Tol = 1.0E-5

    !   allocate( sol( N ), rhs( N ), RWORK( LENW ), sol0( N ), IWORK( LENIW ) )

    !   call random_number( sol0 ); call display( sol0, 'sol0', stdout, .true. )
    !   rhs = matmul( mat, sol0 ); sol = 0.0;

    !   call dsiccg( N, rhs, sol, NELT, cscobj%IA, cscobj%JA, cscobj%A, &
    !     & ISYM, ITOL, TOL, ITMAX, ITER, ERR, IERR, stdout, RWORK, LENW, &
    !     & IWORK, LENIW )

    !   call display( sol, 'sol', stdout, .true. )
    !   call display( abs( sol - sol0 ), 'error', stdout, .true. )
    !   call display( ierr, "ierr")
    ! end block

  end program main