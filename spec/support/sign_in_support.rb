module SignInSupport
  def sign_in(user)
    visit root_path
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on('送信')
    expect(current_path).to eq root_path
  end
end
