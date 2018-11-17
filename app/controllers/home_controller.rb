class HomeController < ApplicationController
  def new
  end

  def create
    output_path = params[:lilypond].try(:path) || ""

    species = {'Primeira Espécie' => '1', 'Segunda Espécie' => '2', 'Terceira Espécie' => '3', 'Quarta Espécie' => '4'}
    species_number = species[params[:species]]
    ascendant = (params[:mode] == 'Superior')
    public_path = Rails.root.join('public').to_s
    bin_path = public_path + '/executable/counterpoint_generator'
    response = system(bin_path + " " + output_path + " " + species_number + " " + ascendant.to_s)
    if response
      response = system("lilypond " + public_path + '/counterpoint.ly')
      if response
        system('mv *.midi public')
        system('mv *.pdf public')
        system('rm public/*.zip')
        input_filenames = ['counterpoint.midi', 'counterpoint.pdf', 'counterpoint.ly']

        zipfile_name = public_path + '/counterpoint.zip'

        Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
          input_filenames.each do |filename|
            zipfile.add(filename, File.join(public_path, filename))
          end
          # zipfile.get_output_stream("myFile") { |f| f.write "myFile contains just this" }
        end
        send_file(zipfile_name)
      end
    end
  end

end
