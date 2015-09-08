puts "Welcome to the ReadyGo Diagnostics Bacterial Identifier!"
puts "For this program, please type word answers in lower case"
bacteria_ID_code = 0
print "What is the gram stain of your bacteria? Enter + or – : "
gram_stain = gets.chomp
bacteria_ID_code += 2 if gram_stain == "-"
print "Next, what is the shape of your bacteria? Coccus or bacillus? "
bacteria_shape = gets.chomp
bacteria_ID_code += 1 if bacteria_shape == "coccus"
#Code is 0 for gram-positive bacilli, 1 for gram-positive cocci, 2 for gram-negative bacilli, and 3 for gram-negative cocci

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
#Function that gets user input for each question and gives us a true/false value to use in narrowing down bacteria ID

#Code to run if user has a gram-positive bacillus
def gp_bacilli_ID
    gram_positive_bacilli = {
        "Lactobacillus" => ["false", "false", "false"],
        "Corynebacteria" => ["false", "false", "true"],
        "Mycobacterium" => ["false", "true"],
        "Bacillus" => ["true", "false"],
        "Clostridium" => ["true", "true"]}
    gp_bacilli_set = []
#The default (if all answers are no) is Lactobacillus, which occupies index zero on our current array
    print "Are the bacteria spore-forming?"
    if yes_or_no(gp_bacilli_set)
            print "Is the bacterium strictly anaerobic?"
            yes_or_no(gp_bacilli_set)
#Only two genuses of gram-positive rods form spores: Clostridium and Bacillus. So we jump to the last two indices of the array. Clostridium strictly grows in anaerobic environments, so we can use that to set it apart from Bacillus
    else
        print "Did the bacteria test positive in the acid-fast test?"
        if !yes_or_no(gp_bacilli_set)
            print "Is the bacteria catalase positive?"
            yes_or_no(gp_bacilli_set)
        end
    end
    gram_positive_bacilli.each {|species, data_set| puts "You have #{species}" if data_set == gp_bacilli_set}
end

#Code to run if a user has a gram-positive coccus
def gp_cocci_ID
        gram_positive_cocci = {
            "Staphylococcus epidermidis" => ["true", "false"],
            "Staphylococcus aureus" => ["true", "true"],
            "Streptococcus agalactiae" => ["false","beta", "false"],
            "Streptococcus pyogenes" => ["false", "beta", "true"],
            "Streptococcus sanguinis" => ["false", "alpha", "false"], 
            "Streptococcus pneumoniae" => ["false", "alpha", "true"],
            "Streptococcus lactis" => ["false", "gamma", "false"],
            "Streptococcus bovis" => ["false", "gamma", "true", "false"],
            "Enterococcus faecalis" => ["false", "gamma", "true", "true"]
        }
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
    gram_positive_cocci.each {|species, data_set| puts "You have #{species}" if data_set == gp_cocci_set}
end    

#Code to run if user has a gram-negative bacilli (more diferrentiating questions to be added)
def gn_bacilli_ID
    gn_bacilli_set = []
    gram_negative_bacilli = {
        "enterobacteria" => ["false"],
        "Pseudomonas" => ["true", "false"],
        "Aeromonas" => ["true", "true", "false"],
        "Vibrio" => ["true", "true", "true"] }
    print "Was the oxidase test positive?"
    #If the oxidase test is negative, it immediately goes to enterobacteria,
    #as this group is known for being oxidase negative. The other tests are 
    #used to further narrow down the species.
    if yes_or_no(gn_bacilli_set)
        print "Did the bacteria ferment glucose?"
        if yes_or_no(gn_bacilli_set)
            print "Is the bacteria sensitive to O/129?"
            yes_or_no(gn_bacilli_set)
        end
    end
    gram_negative_bacilli.each {|species, data_set| puts "You have #{species}" if data_set == gn_bacilli_set}
end    

#Code to run if a user has a gram-negative coccus (or coccobacillus; this code to be added later)
#Some bacteria are considered coccobacilli; these are to be included in Gram-negative bacilli
def gn_cocci_ID
    gram_negative_cocci = {
    "Veillonella" => ["true"],
    "Neisseria meningiditis" => ["false", "true"],
    "Neisseria gonorrhoeae" => ["false", "false", "true"],
    "Moraxella catarrhalis" => ["false", "false", "false"] }
    gn_cocci_set = []
    print "Does this bacteria require anaerobic conditions?"
    if !yes_or_no(gn_cocci_set)
            print "Can the bacteria ferment maltose?"
            if !yes_or_no(gn_cocci_set)
                print "Can the bacteria ferment glucose?"
                yes_or_no(gn_cocci_set)
            end
    end
    gram_negative_cocci.each {|species, data_set| puts "You have #{species}" if data_set == gn_cocci_set}
end

#Where computer decides which function to use based on the basic classification
case bacteria_ID_code
    when 0 then gp_bacilli_ID
    when 1 then gp_cocci_ID
    when 2 then gn_bacilli_ID
    when 3 then gn_cocci_ID
end
