# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # byebug
    if user.admin?
      can :manage, :all
    elsif user.normal_user?
      # byebug
      can :read, :all
      can :assign_assessments, Assessment
      # can :show_assign_assessments, Assessment
    end
  end
end

