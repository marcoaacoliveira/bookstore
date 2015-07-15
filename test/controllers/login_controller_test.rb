require 'test_helper'

class LoginControllerTest < ActionController::TestCase
  test "should get login" do
    get :login
    assert_response :success
    assert_select "form" do
      assert_select "input[type=text][name=email]#email"
      assert_select "input[type=password][name=password]#password"
      assert_select "input[type=submit][value=Autenticar]"
    end
  end

  test "should not login without email and password" do
    post :login
    assert_equal "Informe email e senha", flash[:notice]
  end

  test "should not login without password" do
    post :login, {email: "foo@bar.com"}
    assert_equal "Informe a senha", flash[:notice]
  end

  test "should not login without email" do
    post :login, {password: "teste"}
    assert_equal "Informe o email", flash[:notice]
  end

  test "should not login with a invalid password" do
    person = people(:admin)
    post :login, {email: person.email, password: "foo"}
    assert_equal "Falha no login", flash[:notice]
  end

  test "should not login with a invalid email" do
    post :login, {email: "foo@bar.com", password: "teste"}
    assert_equal "Falha no login", flash[:notice]
  end

  test "should login with valid info" do
    person = people(:admin)
    post :login, {email: person.email, password: "teste"}
    assert_equal  "Bem-vindo, #{person.name}!", flash[:notice]
    assert_equal person.id, session[:id]
    assert_equal person.name, session[:name]
    assert_equal person.admin, session[:admin]
    assert_redirected_to people_path
  end

  test "should get logout" do
    get :logout
    assert_nil session[:id]
    assert_nil session[:name]
    assert_nil session[:admin]
    assert_redirected_to action: :login
  end

  test "should have a login url" do
    assert_generates "/autenticar", {controller: "login", action: "login"}
    assert_recognizes({controller: "login", action: "login"},"/autenticar")
    assert_routing({path: "/autenticar"},{controller: "login", action: "login"})
  end
  test "should have a logout url" do
    assert_generates "/sair", {controller: :login, action: :logout}
    assert_recognizes({controller: "login", action: "logout"},"/sair")
    assert_routing({path: "/sair"},{controller: "login", action: "logout"})
  end

  test "should have an admins routes" do
    assert_routing({path: 'people/admins'}, {controller: 'people', action: 'admins'})
  end
end
