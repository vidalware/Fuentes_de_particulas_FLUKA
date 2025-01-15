      module source_variables

         implicit none

         integer, save :: particle_code
         integer, save :: heavyion_atomic_number, heavyion_mass_number, heavyion_isomer

         double precision, save :: momentum_energy, particle_weight
         logical, save :: energy_logical_flag

         double precision, save :: divergence_x, divergence_y
         logical, save :: gaussian_divergence_logical_flag

         double precision, save :: coordinate_x, coordinate_y, coordinate_z

         integer, save :: direction_flag
         double precision, save :: direction_cosx, direction_cosy, direction_cosz

         double precision, save :: polarization_cosx, polarization_cosy, polarization_cosz

         double precision, save :: particle_age
         double precision, save :: kshort_component
         double precision, save :: delayed_radioactive_decay

         ! Definir parámetros para la grilla
         double precision, parameter :: x_min = -5.0D0
         double precision, parameter :: x_max = 5.0D0
         double precision, parameter :: y_min = -5.0D0
         double precision, parameter :: y_max = 5.0D0
         double precision, parameter :: step = 1.0D0  ! Paso flotante de la grilla

      end module source_variables

      include 'source_library.inc'

*=== Source ===========================================================*

      subroutine SOURCE ( nomore )

      use source_library
      use source_variables

      implicit none

      double precision xdummy
      integer :: nomore, debug_lines = 100
      logical, save :: first_run = .true., debug_logical_flag = .false.

      type(phase_space) phase_space_entry

      ! Declaración de nuevas variables
      double precision, allocatable :: X(:), Y(:)  ! Listas para x e y
      integer :: x_size, y_size  ! Tamaños de las listas
      integer :: x_random_idx, y_random_idx  ! Índices aleatorios
      double precision :: x_random, y_random  ! Valores seleccionados aleatoriamente
      double precision :: theta, phi
      double precision sample_histogram_momentum_energy
      double precision FLRNDM

      ! ====================================
      ! BEGINNING of user declared variables
      ! ====================================

      character(len=50) :: csv_file

      ! ==============================
      ! END of user declared variables
      ! ==============================

      nomore = 0

      call initialization()

      if ( first_run ) then
         ! ==================================
         ! BEGINNING of custom initialization
         ! ==================================

         csv_file = 'No_Shielding.csv'  ! Archivo con la distribución de energía

         ! Calcular los tamaños de las listas para x e y
         x_size = INT((x_max - x_min) / step + 1)
         y_size = INT((y_max - y_min) / step + 1)

         allocate(X(x_size))
         allocate(Y(y_size))

         ! Generar la lista de valores para X e Y
         do x_random_idx = 1, x_size
            X(x_random_idx) = x_min + (x_random_idx - 1) * step
         end do

         do y_random_idx = 1, y_size
            Y(y_random_idx) = y_min + (y_random_idx - 1) * step
         end do

         ! ============================
         ! END of custom initialization
         ! ============================
         first_run = .false.
      end if

      ! ==============================
      ! BEGINNING of customizable code
      ! ==============================

      ! Elegir índices aleatorios para X e Y
      x_random_idx = INT(FLOOR(x_size * FLRNDM(xdummy))) + 1
      y_random_idx = INT(FLOOR(y_size * FLRNDM(xdummy))) + 1

      ! Obtener los valores aleatorios de las listas
      x_random = X(x_random_idx)
      y_random = Y(y_random_idx)

      ! Asignar los valores a las coordenadas
      coordinate_x = x_random
      coordinate_y = y_random
      coordinate_z = -1.0D0

      ! Cargar y samplear energía desde el archivo No_Shielding.csv
      momentum_energy = sample_histogram_momentum_energy(csv_file, 'GeV')
      energy_logical_flag = .true.  ! Indicar que estamos usando energía en lugar de momento

      ! Generar ángulos aleatorios independientes
      phi = 2.0D0 * 3.141592653589793D0 * FLRNDM(xdummy)
      theta = (0.5D0 * 3.141592653589793D0) * FLRNDM(xdummy)  ! theta entre 0 y pi/2

      ! Calcular los cosenos directores en base a theta y phi
      direction_cosx = SIN(theta) * COS(phi)
      direction_cosy = SIN(theta) * SIN(phi)
      direction_cosz = COS(theta)

      ! Debugging
      debug_logical_flag = .true.
      debug_lines = 100

      ! ==============================
      ! END of customizable code
      ! ==============================

      if ( nomore .eq. 0 ) then
         call set_primary()
         if ( debug_logical_flag ) call print_primary( debug_lines )
      end if

      return
*=== End of subroutine Source =========================================*
      end
