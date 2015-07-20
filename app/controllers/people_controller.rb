
class PeopleController < LoggedController
	def admins
		@admins = Person.admins
	end
	
	def changed
	end

	private
	
	def resource_params
		params.require(:person).permit(:name, :email, :plain_password, :born_at, :admin)
	end
end