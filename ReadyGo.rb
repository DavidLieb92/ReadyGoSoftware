puts "Welcome to the ReadyGo Diagnostics Bacterial Identifier!"
puts "For this program, please type word answers in lower case"
bacteria_ID_code = []
print "What is the gram stain of your bacteria? Enter + or – : "
gram_stain = gets.chomp
bacteria_ID_code.push(gram_stain)
print "Next, what is the shape of your bacteria? Coccus or bacillus? "
bacteria_shape = gets.chomp
bacteria_ID_code.push(bacteria_shape)

gram_positive_bacilli = {
    "Bacillus" => ["true", "false"],
    "Clostridium" => ["true", "true"],
    "Mycobacterium" => ["false", "true"],
    "Lactobacillus fermenti" => ["false", "false", "false", "true"],
    "Lactobacillus casei" => ["false", "false", "false", "false", "true"],
    "Lactobacillus delbrueckii" => ["false", "false", "false", "false", "false"],
    "Corynebacterium kutsceri" => ["false", "false", "true", "true"],
    "Corynebacterium xerosis" => ["false", "false", "true", "false"] }

gram_positive_cocci = {
    "Staphylococcus epidermidis" => ["true", "false"],
    "Staphylococcus aureus" => ["true", "true"],
    "Streptococcus agalactiae" => ["false","beta", "false"],
    "Streptococcus pyogenes" => ["false", "beta", "true"],
    "Streptococcus sanguinis" => ["false", "alpha", "false"],
    "Streptococcus pneumoniae" => ["false", "alpha", "true"],
    "Streptococcus lactis" => ["false", "gamma", "false"],
    "Streptococcus bovis" => ["false", "gamma", "true", "false"],
    "Enterococcus faecalis" => ["false", "gamma", "true", "true"] }

gram_negative_bacilli = {
    #Oxidase-positive
    "Pseudomonas aeruginosa" => ["true", "false", "true"],
    "a Pseudomonas species" => ["true", "false", "false"],
    "Aeromonas" => ["true", "true", "false"],
    "Vibrio cholerae" => ["true", "true", "true", "true"],
    "Vibrio vulnificus" => ["true", "true", "true", "false", "true"],
    "Vibrio parahaemolyticus" => ["true", "true", "true", "false", "false"],
    #Oxidase-negative, lactose-negative
    "Non-Lactose fermenting, indole-negative Enterobacteria" => ["false", "false", "false"],
    "Proteus vulgaris" => ["false", "false", "true", "true", "true"],
    "Edwardsiella tarda" => ["false", "false", "true", "true", "false"],
    "Providencia stuartii" => ["false", "false", "true", "false", "true"],
    "Morganella morganii" => ["false", "false", "true", "false", "false"],
    #Oxidase-negative, lactose-positive, indole-positive
    "Eschericia coli" => ["false", "true", "true", "false"],
    "Citrobacter diversus" => ["false", "true", "true", "true", "false"],
    "Erwinia chrysanthemi" => ["false", "true", "true", "true", "true", "true"],
    "Klebsiella oxytoca" => ["false", "true", "true", "true", "true", "false"],
    #Oxidase-negative, lactose-positive, indole-negative
    "Enterobacter intermedius" => ["false", "true", "false", "true", "true"],
    "Citrobacter freundii" => ["false", "true", "false", "true", "false", "true"],
    "Serratia fonticola" => ["false", "true", "false", "true", "false", "false", "true"],
    "Klebsiella pneumoniae, ssp. ozaneae" => ["false", "true", "false", "true", "false", "false", "false"],
    "Klebsiella pneumoniae, ssp. pneumoniae" => ["false", "true", "false", "false", "true", "true", "false"],
    "Serratia rubidaea" => ["false", "true", "false", "false", "true", "true", "true", "true"],
    "Enterobacter aerogenes" => ["false", "true", "false", "false", "true", "true", "true", "false"],
    "Enterobacter cloaceae" => ["false", "true", "false", "false", "true", "false", "true"],
    "Enterobacter amnigenus" => ["false", "true", "false", "false", "true", "false", "false"]
 }
    
gram_negative_cocci = {
    "Veillonella" => ["true"],
    "Neisseria meningiditis" => ["false", "true"],
    "Neisseria gonorrhoeae" => ["false", "false", "true"],
    "Moraxella catarrhalis" => ["false", "false", "false"] }

def yes_or_no(data_set, test_name)
    question_list = {
    "acid-fast" => "Did the bacteria test positive in the acid-fast test?",
    "anaerobic" => "Is the bacteria strictly anaerobic?",
    "bacitracin" => "Is the bacteria sensitive to bacitracin?",
    "bile growth" => "Does the bacteria grow on bile esculin agar?",
    "bile stain" => "Does the bacteria produce a black stain on bile esculin agar?",
    "catalase" => "Is the catalase test positive?",
    "citrate" => "Can the bacteria utilize citrate?",
    "coagulase" => "Does the bacteria produce coagulase?",
    "glucose ferment" => "Can the bacteria ferment glucose?",
    "glucose gas" => "Does the bacteria produce gas during glucose fermentation?",
    "H2S" => "Does the bacteria produce H2S?",
    "indole" => "Is the indole test positive?",
    "lactose" => "Can the bacteria ferment lactose?",
    "lysine" => "Is lysine decarboxylase activity present?",
    "maltose" => "Can the bacteria ferment maltose?",
    "mannitol" => "Can the bacteria utilize mannitol?",
    "methyl red" => "Is the methyl red test positive?",
    "motility" => "Is the bacteria motile?",
    "O/129" => "Is the bacteria sensitive to O/129?",
    "optochin" => "Is the bacteria sensitive to optochin?",
    "orthnithine" => "Is ornithine decarboxylase activity present?",
    "oxidase" => "Is the oxidase test positive?",
    "pigment" => "Is the bacteria pigmented?",
    "pyocyanin" => "Does the bacteria contain pyocyanin pigment?",
    "sorbitol" => "Does the bacteria produce acid from sorbitol?",
    "spore" => "Does the bacteria produce spores?",
    "starch" => "Does the bacteria hydrolyze starch?",
    "TCBS" => "Does the bacteria produce a yellow color on TCBS agar?",
    "urease" => "Does the bacteria produce urease?",
    "VP" => "Is the VP test positive?" }
    question = question_list[test_name]
    print "#{question} Answer yes or no: "
    user_input = gets.chomp
    if user_input == "yes"
        data_set.push("true")
        return true
    elsif user_input == "no"
        data_set.push("false")
        return false
    end
end
#Function that gets user input for each question and
#gives us a true/false value to use in narrowing down bacteria ID

def display_species(species_data, database_name)
   database_name.each {|species, data_set| puts "You have #{species}" if species_data == data_set}
end

#Code to run if user has a gram-positive bacillus
def gp_bacilli_ID
    gp_bacilli_set = []
    if yes_or_no(gp_bacilli_set, "spore")
        yes_or_no(gp_bacilli_set, "anaerobic")
    #Only two genuses of gram-positive rods form spores: Clostridium and Bacillus.
    #Clostridium strictly grows in anaerobic environments, which set it apart from Bacillus
    else
        if !yes_or_no(gp_bacilli_set, "acid-fast")
            if yes_or_no(gp_bacilli_set, "catalase")
                yes_or_no(gp_bacilli_set, "starch")
            else
                if !yes_or_no(gp_bacilli_set, "glucose gas")
                    yes_or_no(gp_bacilli_set, "mannitol")
                end
            end
        end
    end
    return gp_bacilli_set
end

#Code to run if a user has a gram-positive coccus
def gp_cocci_ID
    gp_cocci_set = []
    if yes_or_no(gp_cocci_set, "catalase")
        yes_or_no(gp_cocci_set, "coagulase")
    else
        print "What hemolysis is present? Answer alpha, beta, or gamma: "
        hemolysis = gets.chomp
        gp_cocci_set.push(hemolysis)
    #A catalase negative, gram-positive cocci is a Streptococcus. Based on the hemolysis type,
    #we can further narrow down the specific species
        if hemolysis == "beta"
            yes_or_no(gp_cocci_set, "bacitracin")
        elsif hemolysis == "alpha"
            yes_or_no(gp_cocci_set, "optochin")
        else
            if yes_or_no(gp_cocci_set, "bile growth")
                yes_or_no(gp_cocci_set, "bile stain")
            end
        end
    end
    return gp_cocci_set
end    

#Code to run if user has a gram-negative bacilli (more diferrentiating questions to be added)
def gn_bacilli_ID
    gn_bacilli_set = []
    if yes_or_no(gn_bacilli_set, "oxidase")
        if !yes_or_no(gn_bacilli_set, "glucose ferment")
            yes_or_no(gn_bacilli_set, "pyocyanin")
        else
            if yes_or_no(gn_bacilli_set, "O/129")
                if !yes_or_no(gn_bacilli_set, "TCBS")
                    yes_or_no(gn_bacilli_set, "lactose")
                end
            end
        end
    else
        if yes_or_no(gn_bacilli_set, "lactose")
            if yes_or_no(gn_bacilli_set, "indole")
                if yes_or_no(gn_bacilli_set, "citrate")
                    if yes_or_no(gn_bacilli_set, "VP")
                        yes_or_no(gn_bacilli_set, "H2S")
                    end
                end
            else
                if yes_or_no(gn_bacilli_set, "methyl red")
                    if !yes_or_no(gn_bacilli_set, "VP")
                        if !yes_or_no(gn_bacilli_set, "H2S")
                            yes_or_no(gn_bacilli_set, "motility")
                        end
                    end
                else
                    if yes_or_no(gn_bacilli_set, "VP")
                        if yes_or_no(gn_bacilli_set, "lysine")
                            if yes_or_no(gn_bacilli_set, "motility")
                                yes_or_no(gn_bacilli_set, "pigment")
                            end
                        else
                            yes_or_no(gn_bacilli_set, "sorbitol")
                        end
                    end
                end
            end
        else
            if yes_or_no(gn_bacilli_set, "indole")
                if yes_or_no(gn_bacilli_set, "H2S")
                    yes_or_no(gn_bacilli_set, "urease")
                else
                    yes_or_no(gn_bacilli_set, "ornithine")
                end
            end
        end
    end
    return gn_bacilli_set
end    

#Code to run if a user has a gram-negative coccus (or coccobacillus; this code to be added later)
#Some bacteria are considered coccobacilli; these are to be included in Gram-negative bacilli
def gn_cocci_ID
    gn_cocci_set = []
    print "Does this bacteria require anaerobic conditions?"
    if !yes_or_no(gn_cocci_set, "anaerobic")
        if !yes_or_no(gn_cocci_set, "maltose")
            yes_or_no(gn_cocci_set, "glucose")
        end
    end
    return gn_cocci_set
end

#Where computer decides which function to use based on the basic classification
case bacteria_ID_code
    when ["+","bacillus"] then display_species(gp_bacilli_ID, gram_positive_bacilli)
    when ["+","coccus"] then display_species(gp_cocci_ID, gram_positive_cocci)
    when ["-","bacillus"] then display_species(gn_bacilli_ID, gram_negative_bacilli)
    when ["-","coccus"] then display_species(gn_cocci_ID, gram_negative_cocci)
end
