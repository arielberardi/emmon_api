module Authorization
  extend ActiveSupport::Concern

  included do
    before_action :authorize!
  end

  private

  def authorize!

    case action_name.to_s
    when 'new', 'create'  then auth = current_user_can?(:create)
    when 'index', 'show'  then auth = current_user_can?(:read)
    when 'edit', 'update' then auth = current_user_can?(:update)
    when 'destroy'        then auth = current_user_can?(:delete)
    else
      auth = false
    end

    render json: { errors: 
      [ 'You dont have access to this section.' ]
    }, status: :unauthorized unless auth
  end

  def current_user_can? action

#    user_rule = current_user.role.where(section: CurrentControllerName)

#    case action 
#    when :create then current_user.role.can_create?
#    when :read then current_user.role.can_read?
#    when :update then current_user.role.can_update?
#    when :delete then current_user.role.can_delete?
#    else 
      true
#    end
  end
end                 