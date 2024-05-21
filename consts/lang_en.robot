# since the test cases uses a lot of locators based on texts or placeholders, refactor and add a variable file to better manage
# these hard-coded values
*** Variables ***
# following variables are used in login and logout page
${LOGIN} =    "Login"
${CREATE CLUB}=    "Create Club"
${LOGOUT} =    "Log out"
${LOGOUT YES} =    "Log Out"
${OK} =    "OK"

# following variables are used in profile page
# for profile page
${EDIT PROFILE} =    "Edit Profile"
${SAVE} =    "Save"

# for input fields
${Full Name} =     "Your Name"
${User Name} =     "Your Username"
${High School Name} =    "High School Name"
# for selection fields
${Gender} =     "Select Gender"
${Dream College} =    "Select Dream College"
# for text fields
${Bio} =    "Write something about you"
# for digit fields
${High School Graduation Year} =    "YYYY"