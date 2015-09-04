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

def yes_or_no
    print " Answer yes or no: "
    user_input = gets.chomp
    if user_input == "yes"
            return true
    else
            return false
    end
end
#Function that gets user input for each question and gives us a true/false value to use in narrowing down bacteria ID

#Code to run if user has a gram-positive bacillus
def gp_bacilli_ID
gram_positive_bacilli = ["Lactobacillus", "Corynebacteria", "Mycobacterium", "Bacillus", "Clostridium"]
    gp_bacilli_code = 0
#The default (if all answers are no) is Lactobacillus, which occupies index zero on our current array
    print "Are the bacteria spore-forming?"
    if yes_or_no
            gp_bacilli_code += 3
            print "Is the bacterium strictly anaerobic?"
            gp_bacilli_code += 1 if yes_or_no
#Only two genuses of gram-positive rods form spores: Clostridium and Bacillus. So we jump to the last two indices of the array. Clostridium strictly grows in anaerobic environments, so we can use that to set it apart from Bacillus
    else
            print "Did the bacteria test positive in the acid-fast test?"
            if yes_or_no
                    gp_bacilli_code += 2
            else
                    print "Is the bacteria catalase positive?"
                    gp_bacilli_code += 1 if yes_or_no
            end
    end
    puts "You have a #{gram_positive_bacilli[gp_bacilli_code]}"
end

#Code to run if a user has a gram-positive coccus
def gp_cocci_ID
        gram_positive_cocci = [["Staphylococcus epidermidis", "Staphylococcus aureus"],
        ["Streptococcus agalactiae", "Streptococcus pyogenes"],
        ["Streptococcus sanguinis", "Streptococcus pneumoniae"],
        ["Streptococcus lactis", "Streptococcus bovis", "Enterococcus faecalis"]]
#We have sub-arrays corresponding to characteristic groups. Catalase positive identifies Staph (sub-array 0)
        gp_cocci_code = 0
        gp_cocci_subcode = 0
       print "Is the bacteria catalase positive?"
       if yes_or_no
            print "Is the bacterium coagulase positive?"
            gp_cocci_subcode += 1 if yes_or_no
        else
            gp_cocci_code += 1
            print "What hemolysis is present? Answer alpha, beta, or gamma: "
            hemolysis = gets.chomp
#A catalase negative, gram-positive cocci is a Streptococcus. Based on the hemolysis type, we can further narrow down the specific species
            if hemolysis == "beta"
                    print "Is the bacteria sensitive to bacitracin?"
                    gp_cocci_subcode += 1 if yes_or_no
            elsif hemolysis == "alpha"
                    gp_cocci_code += 1
                    print "Is the bacteria sensitive to optochin?"
                    gp_cocci_subcode += 1 if yes_or_no
            else
                    gp_cocci_code += 2
                    print "Does the bacteria grow on bile esculin agar?"
                    if yes_or_no
                            gp_cocci_subcode += 1
print "Does the bacteria produce a black stain on bile esculin agar?"
                            gp_cocci_subcode += 1 if yes_or_no
                    end
            end
        end
    puts "You have #{gram_positive_cocci[gp_cocci_code][gp_cocci_subcode]}"
end    

#Code to run if user has a gram-negative bacilli (more diferrentiating questions to be added)
def gn_bacilli_ID
    gn_bacilli_code = 0
    gram_negative_bacilli = ["enterobacteria", "Pseudomonas", "Aeromonas", "Vibrio"]
    print "Was the oxidase test positive?"
#If the oxidase test is negative, it immediately goes to enterobacteria, as this group is known for being oxidase negative. The other tests are used to further narrow down the species.
        if yes_or_no
                gn_bacilli_code += 1
                print "Did the bacteria ferment glucose?"
                if yes_or_no
                        gn_bacilli_code += 1
                        print "Is added salt necessary for growth?"
                        if yes_or_no
                            gn_bacilli_code += 1
                        end
                end
        end
    puts "You have #{gram_negative_bacilli[gn_bacilli_code]}"
end    

#Code to run if a user has a gram-negative coccus (or coccobacillus; this code to be added later)
def gn_cocci_ID
    gn_cocci_ID = 0
gram_negative_cocci = ["Moraxella catarrhalis", "Neisseria gonorrhoeae", "Neisseria meningiditis", "Haemophilus influenzae"]
    print "Did growth require X + V factors?"
    if yes_or_no
            gn_cocci_ID += 3
    else
            print "Can the bacteria ferment maltose?"
            if yes_or_no
                    gn_cocci_ID += 2
            else
                    print "Can the bacteria ferment glucose?"
                    gn_cocci_ID += 1 if yes_or_no
            end
    end
    puts "You have #{gram_negative_cocci[gn_cocci_ID]}"
end

#Where computer decides which function to use based on the basic classification
case bacteria_ID_code
    when 0 then gp_bacilli_ID
    when 1 then gp_cocci_ID
    when 2 then gn_bacilli_ID
    when 3 then gn_cocci_ID
end