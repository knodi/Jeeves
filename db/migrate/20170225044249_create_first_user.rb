class CreateFirstUser < ActiveRecord::Migration[5.0]
  def up
    User.create(
      username: 'cknox',
      password: 'asdf',
      email: 'softwaredeveloper@gmail.com',
      text_email: '4695692282@tmomail.net',
    )
  end
  def down
    User.order(:id).first.destroy
  end
end
