require 'test_helper'

class FormHelperTest < ActionView::TestCase

  test 'simple form for yields an instance of FormBuilder' do
    simple_form_for :user do |f|
      assert f.instance_of?(SimpleForm::FormBuilder)
    end
  end

  test 'simple form should add default class to form' do
    concat(simple_form_for(:user) do |f| end)
    assert_select 'form.simple_form'
  end

  test 'simple form should add object name as css class to form when object is not present' do
    concat(simple_form_for(:user) do |f| end)
    assert_select 'form.simple_form.user'
  end

  test 'simple form should add object class name as css class to form' do
    concat(simple_form_for(@user) do |f| end)
    assert_select 'form.simple_form.user'
  end

  test 'pass options to simple form' do
    concat(simple_form_for(:user, :url => '/account', :html => { :id => 'my_form' }) do |f| end)
    assert_select 'form#my_form'
    assert_select 'form[action=/account]'
  end

  test 'fields for yields an instance of FormBuilder' do
    concat(simple_fields_for(:user) do |f|
      assert f.instance_of?(SimpleForm::FormBuilder)
    end)
  end
  
  test 'fields for yields an instance of CustomBuilder if main builder is a CustomBuilder' do
    concat(simple_form_for(:user, :url => '/account', :html => { :id => 'my_form' }, :builder => CustomBuilder) do |form|
      assert form.instance_of?(CustomBuilder)
      
      form.simple_fields_for(:company) do |company|
        assert company.instance_of?(CustomBuilder)
      end
    end)
  end
  
  test 'fields for yields an instance of FormBuilder if it was set in options' do
    concat(simple_form_for(:user, :url => '/account', :html => { :id => 'my_form' }, :builder => CustomBuilder) do |form|
      assert form.instance_of?(CustomBuilder)
      
      form.simple_fields_for(:company, :builder => SimpleForm::FormBuilder) do |company|
        assert company.instance_of?(SimpleForm::FormBuilder)
      end
    end)
  end
end
