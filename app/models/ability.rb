class Ability
  include CanCan::Ability

  def initialize(user)    
    user ||= User.new # Guest user if user hasn't loggend in
    
    if user.role? :admin      
      can :manage, :all
    else      
      if user.is_professional? #user.role?(:professional)
          can :read, Professional, :id => user.id #only if it is the professional profile
          can :update, Professional, :id => user.id          
      else        
        can :create, Event
        can :manage, Event, :user_id => user.id
      end
    end
  end
end