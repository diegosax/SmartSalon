class AdminAbility
  include CanCan::Ability
  def initialize(user)
    user ||= User.new # Guest user if user hasn't loggend in    
    
    if user.role? :admin      
      can :manage, :all
    else      
      if user.is_professional? #user.role?(:professional)          
          can :manage, Client
          
          can :destroy, ClientSalon, :salon_id => user.salon.id 

          can :manage, Service
          can :read, Professional#, :id => user.id #only if it is the professional profile
          can :update, Professional, :id => user.id          
          can :read, Salon, :id => user.salon.id

          can :destroy, ProfessionalService, :professional_id => user.id 
          can :create, ProfessionalService #needs extra check on controller

          can :destroy, WorkingTime, :professional_id => user.id 
          can :create, WorkingTime #needs extra check on controller         
      else        
        can :create, Event
        can :manage, Event, :user_id => user.id
      end
    end
  end
end
