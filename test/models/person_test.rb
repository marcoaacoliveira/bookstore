require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  setup do
  	@person = people(:admin)
  end

  test "tem que ser valido sem alterações" do
  	assert @person.valid?
  end
  
  test "não pode ter nome vazio" do
  	@person.name = ""
  	assert !@person.valid?
  end
  
  test "não pode ter nome maior que 50 caracteres" do
  	@person.name = "*"*51
  	assert !@person.valid?
  end

  test "pode ter email vazio" do
  	@person.email = ""
  	assert @person.valid?
  end

  test "não pode ter email inválido" do
  	@person.email = "foo@bar"
  	assert !@person.valid?
  end

  test "não pode ter email repetido" do
  	new_person = Person.new(@person.attributes)
  	assert !new_person.valid?
  end

  test "a data de nascimento não pode ser menor que 16 anos" do
	@person.born_at = Date.today - 15.years
	assert !@person.valid? 	
  end

  test "a data de nascimento pode ser maior que 16 anos" do
  	@person.born_at = Date.today - 17.years
  	assert @person.valid? 
  end

end
