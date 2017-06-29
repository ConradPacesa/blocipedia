class WikiPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    user.present?
  end

  def edit?
    update?
  end

  def destroy?
    user && user.admin? || wiki.user == user
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user && user.role == 'admin'
        wikis = scope.all
      elsif user && user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if !wiki.private? || wiki.user == user || wiki.collaborators.any?{ |collaborator| collaborator.user_id  == user.id }
            wikis << wiki
          end
        end
      elsif !user
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if !wiki.private?
            wikis << wiki
          end
        end
      else
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if !wiki.private? || wiki.collaborators.any?{ |collaborator| collaborator.user_id  == user.id }
            wikis << wiki
          end
        end
      end
      wikis
    end
  end
end
