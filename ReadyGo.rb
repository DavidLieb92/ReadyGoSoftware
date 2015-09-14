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
    "Lactobacillus" => ["false", "false", "false"],
    "Corynebacterium kutsceri" => ["false", "false", "true", "true"],
    "Corynebacterium xerosis" => ["false", "false", "true", "false"]
     }

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

#The basic format for questions: [oxidase, glucose, lactose]
#If oxidase is positive and glucose is -, [oxidase, glucose, lactose, pyocyanin pigment]
#If oxidase is positive and glucose is +, [oxidase, glucose, lactose, O/129 sensitive, TCBS color == yellow]
gram_negative_bacilli = {
    "Non-Lactose fermenting Enterobacteria" => ["false", "false"],
    "Indole-negative, lactose-fermenting Enterobacteria" => ["false", "true", "false"],
    "Eschericia coli" => ["false", "true", "true", "false"],
    "Citrobacter diversus" => ["false", "true", "true", "true", "false"],
    "Erwinia chrysanthemi" => ["false", "true", "true", "true", "true", "true"],
    "Klebsiella oxytoca" => ["false", "true", "true", "true", "true", "false"]
    "Pseudomonas aeruginosa" => ["true", "false", "true"],
    "a Pseudomonas species" => ["true", "false", "false"],
    "Aeromonas" => ["true", "true", "false"],
    "Vibrio cholerae" => ["true", "true", "true", "true"],
    "Vibrio vulnificus" => ["true", "true", "true", "false", "true"],
    "Vibrio parahaemolyticus" => ["true", "true", "true", "false", "false"]
}
    
gram_negative_cocci = {
    "Veillonella" => ["true"],
    "Neisseria meningiditis" => ["false", "true"],
    "Neisseria gonorrhoeae" => ["false", "false", "true"],
    "Moraxella catarrhalis" => ["false", "false", "false"] }

def yes_or_no(data_set)
    print " Answer yes or no: "
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
    print "Are the bacteria spore-forming?"
    if yes_or_no(gp_bacilli_set)
            print "Is the bacterium strictly anaerobic?"
            yes_or_no(gp_bacilli_set)
    #Only two genuses of gram-positive rods form spores: Clostridium and Bacillus.
    #Clostridium strictly grows in anaerobic environments, which set it apart from Bacillus
    else
        print "Did the bacteria test positive in the acid-fast test?"
        if !yes_or_no(gp_bacilli_set)
            print "Is the bacteria catalase positive?"
            if yes_or_no(gp_bacilli_set)
                print "Does the bacteria hydrolyze starch?"
                yes_or_no(gp_bacilli_set)
            end
        end
    end
    return gp_bacilli_set
end

#Code to run if a user has a gram-positive coccus
def gp_cocci_ID
    gp_cocci_set = []
    print "Is the bacteria catalase positive?"
    if yes_or_no(gp_cocci_set)
        print "Is the bacterium coagulase positive?"
        yes_or_no(gp_cocci_set)
    else
        print "What hemolysis is present? Answer alpha, beta, or gamma: "
        hemolysis = gets.chomp
        gp_cocci_set.push(hemolysis)
    #A catalase negative, gram-positive cocci is a Streptococcus. Based on the hemolysis type,
    #we can further narrow down the specific species
        if hemolysis == "beta"
            print "Is the bacteria sensitive to bacitracin?"
            yes_or_no(gp_cocci_set)
        elsif hemolysis == "alpha"
            print "Is the bacteria sensitive to optochin?"
            yes_or_no(gp_cocci_set)
        else
            print "Does the bacteria grow on bile esculin agar?"
            if yes_or_no(gp_cocci_set)
                print "Does the bacteria produce a black stain on bile esculin agar?"
                yes_or_no(gp_cocci_set)
            end
        end
    end
    return gp_cocci_set
end    

#Code to run if user has a gram-negative bacilli (more diferrentiating questions to be added)
def gn_bacilli_ID
    gn_bacilli_set = []
    print "Was the oxidase test positive?"
    if yes_or_no(gn_bacilli_set)
        print "Can the bacteria ferment glucose?"
        if !yes_or_no(gn_bacilli_set)
            print "Does the bacteria contain pyocyanin pigment?"
            yes_or_no(gn_bacilli_set)
        else
            print "Is the bacteria sensitive to O/129?"
            if yes_or_no(gn_bacilli_set)
                print "Does the bacteria produce a yellow color on TCBS agar?"
                if !yes_or_no(gn_bacilli_set)
                    print "Did the bacteria ferment lactose?"
                    yes_or_no(gn_bacilli_set)
                end
            end
        end
    else
        print "Can the bacteria ferment lactose?"
        if yes_or_no(gn_bacilli_set)
            print "Is the indole test positive?"
            if yes_or_no(gn_bacilli_set)
                print "Can the bacteria use citrate?"
                if yes_or_no(gn_bacilli_set)
                    print "Is the VP test positive?"
                    if yes_or_no(gn_bacilli_set)
                        print "Does the bacteria produce H2S?"
                        yes_or_no(gn_bacilli_set)
                    end
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
    if !yes_or_no(gn_cocci_set)
        print "Can the bacteria ferment maltose?"
        if !yes_or_no(gn_cocci_set)
            print "Can the bacteria ferment glucose?"
            yes_or_no(gn_cocci_set)
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
