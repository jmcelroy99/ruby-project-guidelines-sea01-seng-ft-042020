class CommandLineInterface
    attr_reader :beer_name


    def menu
        puts "Welecome to Beer Finder! Please pick one of the following options below? (input number)"
        puts "1 - What Brewery is my Beer From? 2- See Beer Reviews 3 - Review a Beer 4- See Reviews 5- Update Reviews 6- Delete Review"
        menu_choice
    end

    def menu_choice
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

        # id: 151, beer_id: nil, user_id: nil, rating: nil, review
        puts  "\nWhat is your username?"
        review_username = gets.chomp
        review_username_instance = User.where(username: review_username)
        review_username_id = review_username_instance.map{|user|user.id}.first

        puts "\nWhat Beer are you reviewing?"
        beer_reviewing = gets.chomp
        beer_reviewing_instance = Beer.where(beer_name: beer_reviewing)
        beer_reviewing_id = beer_reviewing_instance.map{|beer|beer.id}.first

        puts "\nWhat is your rating?(1-5)"
            review_rating = gets.chomp
        puts "Type your Review here!"
            review_answer = gets.chomp

        Review.create(beer_id: beer_reviewing_id, user_id: review_username_id, rating: review_rating, review: review_answer)
        see_review
    end

    def update_review
        puts "What is your username"
            answer = gets.chomp
        puts "\nHere are your reviews"
            review_username_instance = User.where(username: answer)
            review_username_id = review_username_instance.map{|user|user.id}.first
            reviews = Review.where(user_id: review_username_id)
            reviews.map do |review|
                puts "\nReview id: #{review.id}\n"
                puts "#{review.review}\n"
                puts "Beer id: #{review.beer_id}\n"
            end
        puts "\nInsert id of the review that you would like to edit"
            selected_id = gets.chomp
        puts "\nWhat Beer are you reviewing?"
            beer_reviewing = gets.chomp
            beer_reviewing_instance = Beer.where(beer_name: beer_reviewing)
            beer_reviewing_id = beer_reviewing_instance.map{|beer|beer.id}.first
        puts "\nWhat is your rating?(1-5)"
            review_rating = gets.chomp
        puts "\nType your Review here!"
            review_answer = gets.chomp

        review_selected = Review.find_by(id: selected_id)
        review_selected.update(id: selected_id, beer_id: beer_reviewing_id, user_id: review_username_id, rating: review_rating, review: review_answer)
        return_to_menu
    end

    def delete_review
        puts "What is your username"
            answer = gets.chomp
        puts "\nHere are your reviews"
            review_username_instance = User.where(username: answer)
            review_username_id = review_username_instance.map{|user|user.id}.first
            reviews = Review.where(user_id: review_username_id)
            reviews.map do |review|
                puts "\nReview id: #{review.id}\n"
                puts "#{review.review}\n"
                puts "Beer id: #{review.beer_id}\n"
            end
        puts "\nInsert id of the review that you would like to delete"
            selected_id = gets.chomp

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


end
