namespace :dev do

  desc "Setup development"
  task setup_dev: :environment do
  images_path = Rails.root.join('public','system')

    puts "Running setup development task ..."

    puts "Dropping DB... #{%x(rake db:drop)}"
    puts "Erasing images from public folder ...#{%x(rm -rf #{images_path})}"

    puts "Creating DB... #{%x(rake db:create)}"
    puts %x(rake db:migrate)
    puts %x(rake db:seed)
    puts %x(rake dev:generate_admins)
    puts %x(rake dev:generate_members)
    puts %x(rake dev:generate_ads)

    puts "Task completed successfully"

  end

  #################################################################
#
  desc "Criar administradores fake"
  task generate_admins: :environment do
    10.times do
      puts "Cadastrando administrador..."

      Admin.create!(name: Faker::Name.name,
                    email: Faker::Internet.email,
                    password: "123456",
                    password_confirmation: "123456",
                    role: [0,0,1,1,1].sample)
    end

    puts "Administradores criados!"

  end

#################################################################
#
  desc "Criar membros fake"
  task generate_members: :environment do
    10.times do
      puts "Cadastrando membro..."

      Member.create!(email: Faker::Internet.email,
                    password: "123456",
                    password_confirmation: "123456")
    end

    puts "Membros criados!"

  end
#################################################################
#
  desc "Cria Anúncios Fake"
  task generate_ads: :environment do
    puts "Cadastrando ANÚNCIOS..."

    5.times do
      Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description: LeroleroGenerator.paragraph([1,2,3].sample),
        member: Member.first,
        category: Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}",
        finish_date: Date.today + Random.rand(90),
        picture: File.new(Rails.root.join('public','templates','images-for-ads',"#{Random.rand(9)}.jpg"), 'r')
      )
    end

    100.times do
      Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description: LeroleroGenerator.paragraph([1,2,3].sample),
        member: Member.all.sample,
        category: Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}",
        picture: File.new(Rails.root.join('public','templates','images-for-ads',"#{Random.rand(9)}.jpg"), 'r'),
        finish_date: Date.today + Random.rand(90)
      )
    end

    puts "ANÚNCIOS criados ..."
  end

end
