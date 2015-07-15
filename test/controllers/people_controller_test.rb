require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  setup do
    @person = people(:admin)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:people)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create person" do
  	new_password = "novasenha"
  	@person.email= "functional@test.com"


  	assert_difference('Person.count') do
  		post :create, person: {admin: @person.admin, born_at: @person.born_at, email: @person.email, name: @person.name, plain_password: new_password}
  	end

  	person = assigns(:person)
  	assert_not_nil person
  	assert_equal Person.encrypt_password(new_password), person.password
  	assert_redirected_to person_path(person)
  end

  test "should show person" do
    get :show, id: @person
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @person
    assert_response :success
  end

  test "should update person" do
    patch :update, id: @person, person: { admin: @person.admin, born_at: @person.born_at, email: @person.email, name: @person.name, password: @person.password }
    assert_redirected_to person_path(assigns(:person))
  end

  test "should destroy person" do
    assert_difference('Person.count', -1) do
      delete :destroy, id: @person
    end

    assert_redirected_to people_path
  end
  
  test "should not create person with encrypted password" do
	@person.email = "functional@test.com"
	assert_difference('Person.count') do
	post :create, person: { admin: @person.admin, born_at: @person.born_at,\
	email: @person.email, name: @person.name, password: "teste" }
	end
	assert_nil assigns(:person).password
  end
  
  test "should update person encrypted password" do
	old_password = @person.password
	patch :update, id: @person, person: { admin: @person.admin, born_at: @person.born_at, email: @person.email, name: @person.name, password: "teste" }
	assert_equal old_password, assigns(:person).password
	assert_redirected_to person_path(assigns(:person))
  end

  test "should have a changed route" do
  	assert_routing({path: "people/#{@person.id}/changed"}, {controller: "people", action: "changed", id: @person.id.to_param})
  end

  test "should show info about when a person has changed" do
  	get :changed, id: @person.id
  	assert_response :success
  	assert assigns(:person)
  	assert_select "p#name" , text: "Nome: #{@person.name}"
  	assert_select "p#created", text: "Criado em: #{I18n.localize(@person.created_at)}"
  	assert_select "p#updated", text: "Alterado em: #{I18n.localize(@person.updated_at)}"
  end

  test "should list all the admins" do
    get :admins
    assert_response :success
    assert assigns(:admins)
    assert_select "table" do
      assert_select "tbody" do
        assert_select "tr", 1
      end
    end
  end
end
