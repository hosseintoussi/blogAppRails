class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif user.moderator?
      can :manage, :all
      cannot :manage, User
    elsif user.user?
      can [:read, :create], Article
      can [:update, :destroy], Article do |article|
        article.owned_by?(user)
      end
      can [:read, :create], Comment
      can [:update, :destroy], Comment do |comment|
        comment.owned_by?(user)
      end
    elsif user.banned?
      # not yet
    else
      can :read, Article
    end
  end
end
