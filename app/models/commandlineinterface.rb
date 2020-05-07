class CommandLineInterface
    attr_reader :beer_name


    def greeting
        puts ("
            

            ██████╗░███████╗███████╗██████╗░  ███████╗██╗███╗░░██╗██████╗░███████╗██████╗░
            ██╔══██╗██╔════╝██╔════╝██╔══██╗  ██╔════╝██║████╗░██║██╔══██╗██╔════╝██╔══██╗
            ██████╦╝█████╗░░█████╗░░██████╔╝  █████╗░░██║██╔██╗██║██║░░██║█████╗░░██████╔╝
            ██╔══██╗██╔══╝░░██╔══╝░░██╔══██╗  ██╔══╝░░██║██║╚████║██║░░██║██╔══╝░░██╔══██╗
            ██████╦╝███████╗███████╗██║░░██║  ██║░░░░░██║██║░╚███║██████╔╝███████╗██║░░██║
            ╚═════╝░╚══════╝╚══════╝╚═╝░░╚═╝  ╚═╝░░░░░╚═╝╚═╝░░╚══╝╚═════╝░╚══════╝╚═╝░░╚═╝
            
            ").colorize(:yellow).colorize(:background => :cyan)
        puts "\nWelecome to Beer Finder! Please pick one of the following options below? (input number)".colorize(:light_blue)
        user_login
    end





    def user_login 
        puts "\nPlease enter your Username"
        answer = gets.chomp
        if User.find_by(username: answer)
            puts "Welcome #{answer}"
            menu
        else
            puts "Username does not exist. Please create username"
            new_user = gets.chomp
            User.create(username: new_user)
            user_login
        end
    end

    def menu
        puts"\n1 - What Brewery is my Beer From?\n 2- See Beer Reviews\n 3- Review a Beer\n 4- See Reviews\n 5- Update Reviews\n 6- Delete Review\n 7- Beer Rating\n"
        answer = gets.chomp
        case answer 
        when "1"
            beer_search
        when "2"
            beer_review
        when "3"
            create_review
        when "4"
            see_review
        when "5"
            update_review
        when "6"
            delete_review
        when "7"
            beer_rating
        else 
            return_to_menu
        end

    end

    def return_to_menu
        puts "Would you like to return to the menu?(Y/n)"
        answer = gets.chomp
        if answer == "Y"
            menu
        elsif answer == "n"
            puts "Thank you for using Beer Finder"
            exit
        else
            puts "Invalid command"
            menu
        end
    end

    def beer_search
        puts "Want to know where your beer is from? (enter beer name)"
        answer = gets.chomp
        if Beer.exists?(beer_name: answer)
            beer_names = answer
        else
            puts "This beer has not been rated"
        end
        beer_names = Beer.where(beer_name: answer)
        breweries = beer_names.map {|beer| Review.find(beer.brewery_id)}
        breweries.each {|review|puts review.beer.brewery.brewery_name}
        return_to_menu
    end

    def beer_review
        puts "Want to see reviews on a beer? (enter beer name)"
        answer = gets.chomp
        beer_names = Beer.where(beer_name: answer)
        beer_id = beer_names.map {|beer|beer.id}
        review_of_beer = Review.where(beer_id: beer_id)
        all_reviews = review_of_beer.map{|review|review.review}
        all_reviews.each {|review| puts review}
        return_to_menu
    end

    def create_review
        puts  "\nWhat is your username?"
        review_username = gets.chomp
        review_username_instance_for_validation = User.where(username: review_username)
        review_username_id_for_validation = review_username_instance_for_validation.map{|user|user.id}.first
        if review_username_id_for_validation
            review_username = review_username
        else 
            puts "Username does not exist"
            create_review
        end
        review_username_instance = User.where(username: review_username)
        review_username_id = review_username_instance.map{|user|user.id}.first

        puts "\nWhat Beer are you reviewing?"
        beer_reviewing = gets.chomp
        if Beer.exists?(beer_name: beer_reviewing)
            beer_reviewing = beer_reviewing
        else
            puts "We're sorry, this beer does not exist in our system."
            return_to_menu
        end

        beer_reviewing_instance = Beer.where(beer_name: beer_reviewing)
        beer_reviewing_id = beer_reviewing_instance.map{|beer|beer.id}.first

        puts "\nWhat is your rating?(1-5)"
            review_rating = gets.chomp.to_f
            if review_rating.between?(1,5)
                review_rating = review_rating
            else 
            puts "Invalid Rating: Must be between 1-5"
            create_review
            end
        puts "Type your Review here!"
            review_answer = gets.chomp

        Review.create(beer_id: beer_reviewing_id, user_id: review_username_id, rating: review_rating, review: review_answer)
        see_review
    end

    def update_review
        puts "What is your username"
            review_username = gets.chomp
            review_username_instance_for_validation = User.where(username: review_username)
            review_username_id_for_validation = review_username_instance_for_validation.map{|user|user.id}.first
            if review_username_id_for_validation
                review_username = review_username
            else 
                puts "Username does not exist"
                return_to_menu
            end
        puts "\nHere are your reviews"
            review_username_instance = User.where(username: review_username)
            review_username_id = review_username_instance.map{|user|user.id}.first
            reviews = Review.where(user_id: review_username_id)
            reviews.map do |review|
                puts "\nReview id: #{review.id}\n"
                puts "#{review.review}\n"
                puts "Beer id: #{review.beer_id}\n"
            end
        puts "\nInsert id of the review that you would like to edit"
            selected_id = gets.chomp
            selected_id_instance_for_validation = Review.where(id: selected_id)
            reviewer_id_for_selected_id = selected_id_instance_for_validation.map{|reviewer|reviewer.user_id}.first
            selected_id_for_validation = selected_id_instance_for_validation.map{|review|review.id}.first
            if review_username_id_for_validation == reviewer_id_for_selected_id
                selected_id = selected_id_for_validation
            else 
                puts "Review does not exist or does not belong to you"
                return to menu
            end
        puts "\nWhat Beer are you reviewing?"
        beer_reviewing = gets.chomp
        if Beer.exists?(beer_name: beer_reviewing)
            beer_reviewing = beer_reviewing
        else
            puts "We're sorry, this beer does not exist in our system."
            return_to_menu
        end

        beer_reviewing_instance = Beer.where(beer_name: beer_reviewing)
        beer_reviewing_id = beer_reviewing_instance.map{|beer|beer.id}.first

        puts "\nWhat is your rating?(1-5)"
            review_rating = gets.chomp.to_f
            if review_rating.between?(1,5)
                review_rating = review_rating
            else 
            puts "Invalid Rating: Must be between 1-5"
            create_review
            end
        puts "\nType your Review here!"
            review_answer = gets.chomp

        review_selected = Review.find_by(id: selected_id)
        review_selected.update(id: selected_id, beer_id: beer_reviewing_id, user_id: review_username_id, rating: review_rating, review: review_answer)
        return_to_menu
    end

    def delete_review
        puts "What is your username"
            review_username = gets.chomp
            review_username_instance_for_validation = User.where(username: review_username)
            review_username_id_for_validation = review_username_instance_for_validation.map{|user|user.id}.first
            if review_username_id_for_validation
                review_username = review_username
            else 
                puts "Username does not exist"
                return_to_menu
            end
        puts "\nHere are your reviews"
            review_username_instance = User.where(username: review_username)
            review_username_id = review_username_instance.map{|user|user.id}.first
            reviews = Review.where(user_id: review_username_id)
            reviews.map do |review|
                puts "\nReview id: #{review.id}\n"
                puts "#{review.review}\n"
                puts "Beer id: #{review.beer_id}\n"
            end
        puts "\nInsert id of the review that you would like to delete"
            selected_id = gets.chomp
            selected_id_instance_for_validation = Review.where(id: selected_id)
            reviewer_id_for_selected_id = selected_id_instance_for_validation.map{|reviewer|reviewer.user_id}.first
            selected_id_for_validation = selected_id_instance_for_validation.map{|review|review.id}.first
            if review_username_id_for_validation == reviewer_id_for_selected_id
                selected_id = selected_id_for_validation
            else 
                puts "Review does not exist or does not belong to you"
                return to menu
            end

        review_selected = Review.find_by(id: selected_id).destroy
        return_to_menu
    end


    def see_review
        puts "Want to see your reviews? (enter username)"
        answer = gets.chomp
        review_username_instance = User.where(username: answer)
        review_username_id = review_username_instance.map{|user|user.id}.first
        reviews = Review.where(user_id: review_username_id)
        list_of_review_ids = reviews.map{|review|review.review}
        list_of_review_ids.each {|review| puts review}
        return_to_menu
    end

    def beer_rating
        puts "Want to see ratings on a beer? (enter beer name)"
        answer = gets.chomp
        beer_names = Beer.where(beer_name: answer)
        beer_id = beer_names.map {|beer|beer.id}
        rating_of_beer = Review.where(beer_id: beer_id)
        all_ratings = rating_of_beer.map{|rating|rating.rating}
        average_beer_rating = all_ratings.sum/all_ratings.count.to_f
        puts average_beer_rating
        return_to_menu
    end

    
end
