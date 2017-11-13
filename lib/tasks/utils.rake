namespace :utils do
  desc "Criar administradores fake"
  task generate_admins: :environment do
    10.times do
      puts "Cadastrando administrador..."

      Admin.create!(email: Faker::Internet.email,
                    password: "123456",
                    password_confirmation: "123456")
    end

    puts "Administradores criados!"

  end

end
