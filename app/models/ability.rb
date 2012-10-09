class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # Guest user if user hasn't loggend in

    puts "######################################### ID: " + user.id.to_s
    puts "######################################### is_professional?: " + user.is_professional?.to_s

    if user.role? :admin
      can :manage, :all
    else
        if user.is_professional? #user.role?(:professional)
            can :read, Professional do |professional|
              professional.id == user.id #only if it is the professional profile
            end
            can :update, Professional do |professional|
              professional.id == user.id #only if it is the professional profile
            end
        end
    end
  end
end