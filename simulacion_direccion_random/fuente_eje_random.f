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

      ! Function declarations
      ! Declaración de nuevas variables
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

         ! ============================
         ! END of custom initialization
         ! ============================
         first_run = .false.
      end if

      ! ==============================
      ! BEGINNING of customizable code
      ! ==============================

      ! Cargar y samplear energía desde el archivo No_Shielding.csv
      momentum_energy = sample_histogram_momentum_energy(csv_file, 'GeV')
      energy_logical_flag = .true.  ! Indicar que estamos usando energía en lugar de momento

      ! Definir otros parámetros de la fuente
      coordinate_x = 0.0D0
      coordinate_y = 0.0D0
      coordinate_z = -1.0D0

      ! 6.1. Direction cosines
      ! ----------------------
      ! Sets the direction cosines of the beam with respect to the X,Y and Z-axis
      ! Defaults:
      !    Set on the BEAMPOS card if present, otherwise (0.0D0, 0.0D0, 1.0D0)

      ! Generamos los ángulos aleatorios independientes
      ! Phi entre 0 y 2pi
      phi = 2.0D0 * 3.141592653589793D0 * FLRNDM(xdummy)

      ! Theta entre 0 y pi/2 para asegurar dirección positiva en z
      theta = (0.5D0 * 3.141592653589793D0) * FLRNDM(xdummy)  ! theta entre 0 y pi/2

      ! Calculamos los cosenos directores en base a theta y phi
      direction_cosx = SIN(theta) * COS(phi)
      direction_cosy = SIN(theta) * SIN(phi)
      direction_cosz = COS(theta)
      

      ! 10. Debugging
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
