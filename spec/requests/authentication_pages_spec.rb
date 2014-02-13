require 'spec_helper'

describe "AuthenticationPages" do
	subject { page }	

	describe "signin page" do
		before { visit signin_path }
		it { should have_content('Sign in') }
		it { should have_title('Sign in') }
		describe "with invalid information" do
			before { click_button "Sign in" }
			it { should have_selector('div.alert.alert-error') }
			describe "after visiting another page" do
				before { click_link "Home" }
				it { should_not have_selector('div.alert.alert-error') }
			end
		end
		
		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user) }
#			before do 
#				fill_in "Email", 		with: user.email.upcase
#				fill_in "Password", with: user.password
#				click_button "Sign in"
#			end
			before { sign_in user }
			it { should have_title(user.name) }
			it { should have_link('Users', href: users_path) }
			it { should have_link('Setting', href: edit_user_path(user)) }
			it { should have_link('Profile', href: user_path(user)) }
			it { should have_link('Sign out', href: signout_path) }
			it { should_not have_link('Sign in', href: signin_path) }
		end
	end
	
	describe "authentication" do
		describe "for non-signed-in users" do
			let(:user) { FactoryGirl.create(:user) }
			describe "in the Users controller" do
				describe "visiting the edit page after sign in" do
					before do
						visit signin_path
						fill_in "Email", with: user.email.upcase
						fill_in "Password", with: user.password
						click_button "Sign in"
						visit edit_user_path(user)
					end
					it { should have_content('Sign out') }
				end
				describe "visiting the edit page before sign in" do
					before { visit edit_user_path(user) }
					it { should have_title('Sign in') }
				end
				describe "submitting to the update action" do
					before { patch user_path(user) }
					specify { expect(response).to redirect_to(signin_path) }
				end
			end

			describe "visiting the user index" do
				before { visit users_path }
				it { should have_title('Sign in') }
			end
		end

		describe "as wrong user" do
			let(:user) { FactoryGirl.create(:user) }
			let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
			before { sign_in user, no_capybara: true }
			describe "submitting a GET requet to the User#edit action" do
				before { get edit_user_path(wrong_user) }
				specify { expect(response.body).not_to match(full_title('Edit user')) }
				specify { expect(response).to redirect_to(root_url) }
			end
			describe "submitting a PATCH requet to the Users#update action" do
				before { patch user_path(wrong_user) }
				specify { expect(response).to redirect_to(root_url) }
			end
		end
	end
end
