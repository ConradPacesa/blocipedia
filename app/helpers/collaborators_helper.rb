module CollaboratorsHelper
  def not_collaborator?(collaborators, id)
    collaborators.each do |c|
      if c.user_id == id
        break
      end
    end
  end
end
