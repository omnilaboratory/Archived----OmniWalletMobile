# OmniWalletMobile
Native Mobile wallet for Omnilayer assets， released on Android and IOS.

# What is OmniWalletMobile

OmniWalletMobile is a new type of mobile wallet, providing Bitcoin&Omnilayer users with an unrivaled blend of security and ease-of-use. It is completely open source including standard backend services and mobile side app written in Dart(Flutter framework initialted by Google).

It currently supports Bitcoin and OMNI, and all OmniProtocol created tokens. In addition, and most importantly, its trustless security mechanism grantees the safty of uers' assets. 

# Clone the repo
```
git clone https://github.com/LightningOnOmnilayer/OmniWalletMobile.git
cd LightningOnOmnilayer/OmniWalletMobile
```

# Security Assessment
Server attacked 

>The user ID, ie the mnemonic code, and the PIN code are stored in MD5, then hackers can only get encrypted text. The only information in plain text the the wallet addresses, which are meant to be known in using a wallet funtions.

Server crashed, data loss

>Use mnemonic code to restore accounts at any other wallet supporting omni protocol. User's asset will not be loss.

Mobile phone lost(local data compromised)

>mnemonic code and PIN code are stored in MD5, if screen of the device is locked, user's data is safe, hence his assets. In addition, single logon mechanism makes sure that if a user logon on his another device and change the pin code as soon as he find one lost, the missing device will be locked immediatly and will never be unlocked.

mnemonic code backed up in plain text stolen

>*Important*: there is no way in the world to protect your assets if your mnemonic code is known to others. Anyone including yourself can restore your account using the code on any other third party wallets. So write down the code on a paper, and lock the paper at a safe place, which is known to yourself only. 




