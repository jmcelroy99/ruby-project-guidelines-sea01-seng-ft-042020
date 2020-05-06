require_relative '../config/environment'

cli = CommandLineInterface.new

cli.menu

breweries = cli.beer_search

br = cli.beer_review

ar = cli.see_review

ur = cli.update_review
