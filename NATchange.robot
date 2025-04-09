*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${EDGE_OPTIONS}    --user-data-dir=C:\\Temp\\EdgeProfile
${username}       \
${password}       \
${code}           \

*** Test Cases ***
Open Browser With Unique Profile
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].EdgeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    ${EDGE_OPTIONS}
    Create WebDriver    Edge    options=${options}
    Go To    http://192.168.1.1    #Opening webpage
    Sleep    2s
    Input Text    xpath=//*[@id="username"]    ${username} #Entering Username
    Input Password    xpath=//*[@id="psd"]    ${password}    #Entering Password
    Input Text    xpath=//*[@id="verification_code"]    ${code}    #Entering the varification code
    Click Element    xpath=/html/body/form/p[6]/table[2]/tbody/tr[2]/td[2]/table/tbody/tr[3]/td[2]/input[1]    #Click on Login
    sleep    3s
    #Select Frame    xpath=/html/body/blockquote/div/form/table/tbody/tr[2]/td[2]/select    #Selecting the Network frame
    Click Element    xpath=//*[@id="topmenu"]/td[2]/p/b/font/a/span    #Click Network
    Click Element    xpath=//*[@id="lstmenu"]/tbody/tr[2]/td/p/a    #Click NAT cnfiguration
    Click Element    xpath=/html/body/blockquote/div/form/table/tbody/tr[2]/td[2]/select    #Click NAT button
    Press Keys    {DOWN}    #Changing the NAT to NAT1
    Click Element    xpath=/html/body/blockquote/div/form/input[1] #Click Apply
    Click Element    xpath=//*[@id="topmenu"]/td[5]/p/b/font/a/span\n #Click Management
    Click Element    xpath=//*[@id="submenu"]/td[3]/p/a/span    #Click Device Management
    Click Element    xpath=//*[@id="form"]/p/input[1] #Click Save/Reboot
    sleep    75s    #Wait period for rebooting
    Close Browse    #Close browser
