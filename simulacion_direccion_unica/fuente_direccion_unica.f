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

      direction_cosx = 0.0D0
      direction_cosy = 0.5D0
      direction_cosz = 0.866D0

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
