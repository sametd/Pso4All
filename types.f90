module types
  use config
  implicit none
  
    type Point
      real(dp),dimension(NPARAM)::p
      real(dp)::o
    end type Point

    type Particle
      type(Point)::cur
      type(Point)::bst
      real(dp),dimension(NPARAM)::v
      real(dp)::w
    end type Particle

end module types