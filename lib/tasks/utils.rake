namespace :utils do
  desc "Criar administradores fake"
  task generate_admins: :environment do
    10.times do
      puts "Cadastrando administrador..."

      Admin.create!(name: Faker::Name.name,
                    email: Faker::Internet.email,
                    password: "123456",
                    password_confirmation: "123456",
                    role: [0,1].sample)
    end

    puts "Administradores criados!"

  end

  desc "Cria Anúncios Fake"
  task generate_ads: :environment do
    puts "Cadastrando ANÚNCIOS..."

    100.times do
      Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description: LeroleroGenerator.paragraph(Random.rand(3)),
        member: Member.all.sample,
        caregory: Category.all.sample
      )
    end

    puts "ANÚNCIOS criados ..."
  end

end
