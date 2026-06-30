---
title: "Don't Commit Sensitive Information to the Repository"
date: 2023-11-06
categories: 
  - "security"
tags: 
  - "credentials"
  - "security"
coverImage: "ProperlyAccessDbCredentials_FullEditor.png"
---

One of the most common security issues I in code reviews is sensitive information, such as production credentials, API keys, etc, in the source code. The source code I just pulled from the repository. The source code all the developers before me have also pulled down to their local computers. Developers who might not work at the company anymore.

Most people are honest and won't do anything bad with the information but there are exceptions. Even if developer is honest they might accidently expose the sensitive information such as a stolen laptop or their home network getting compromised.

Some examples of sensitive information I've seen:

- AWS Simple Email Service (SES) key: This can be used by others to send email as if they are your company. I've seen it used by spammers and once AWS notices they will disable your SES account until you can prove to them the problem is fixed.

- Production Database credentials: Often this is not a high priority issue because the database is usually not publicly accessible (i.e. behind a firewall) but in one case the production database was accessible on the internet.

- FTP credentials to Government Services: Attackers could upload malicious files as if they where company in question.

- Private SSH for Production: With this key anyone can log into to production but also pretend to be the production server.

**Where to store sensitive information?**

Credential and API keys should be kept in a password manager ([1Password](https://1password.com/), [BitWarden](https://bitwarden.com/), etc) or a secrets manager ([AWS Secrets Manager](https://aws.amazon.com/secrets-manager/), [Azure Key Vault](https://azure.microsoft.com/en-us/products/key-vault/), etc).

For local development developers shouldn't need access to the production environments. Instead they should setup the services they need access to on their local development environment such as a local development database.

For 3rd party services that can't be installed or mimcied locally developers should be given access to a test/development copy. For example, a test S3 bucket instead of production.

Applications should read sensitive information from environment variables. Most frameworks provide a way to store environment variables in a file, usually called `.env`, and read this file when the application starts. This file contains key-value pairs and looks like:

```
DB_USER=username
DB_PASSWORD=password
DB_SERVER=server.com
DB_NAME=prod_db

AWS_S3_BUCKET=prod-bucket.s3.us-east.amazonaws.com
AWS_S3_BUCKET_KEY=production_key
AWS_S3_BUCKET_SECRET=produciton_secrect
```

The `.env` should never be committed to the repository and ideally added to the `.gitignore` or equivalent. Instead I recommended committing a `.example.env` file to the repository which has all the keys expected but not the values. At least not the production values, but possibly some development values. When a developer first sets up their development environment they copy the `.env.example` to `.env` and fill in the missing values that they find in the password manager:

```
DB_USER=devuser
DB_PASSWORD=<local db password>
DB_SERVER=localhost
DB_NAME=dev_db

AWS_S3_BUCKET=test-bucket.s3.us-east.amazonaws.com
AWS_S3_BUCKET_KEY=<get from password manager>
AWS_S3_BUCKET_SECRET=<get from password manager>
```

**How to fix the problem?**

Unfortunately you can't just remove the sensitive information because it is still viewable in the repository history. Also, it might also exist on others that have forked the repository.

If there are multiple credentials you need to remove then pick one and do the following:

1. Add the sensitive information to your password or secret manager.

3. Setup a `.env` file, or something similar, if it does not exist.

5. Move the sensitive information to the `.env` file.

7. Do a release to test you have the sensitive information migrated correctly. You will need to add the sensitive information to the staging/production environment variables or files.

9. Change the sensitive information (change password, regenerate API key, etc). This should only require an update to the system and the environment variable in production.

Repeat the above steps for the next piece of sensitive information until they are all removed from the respository.

Additional information:

- [12 Factor App - Config](https://12factor.net/config)

- [MenderCon 2022 - Creating a Pleasant Development Environment](https://www.youtube.com/watch?v=XcwrOLShGSY)

- [OWASP Secrets Management Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Secrets_Management_Cheat_Sheet.html)

- [OWASP Use of Hard-Coded Password](https://owasp.org/www-community/vulnerabilities/Use_of_hard-coded_password)

P.S. - Not related to the above post. I'm just really like the new [Blink-182](https://www.blink182.com/) album.

_Do I have to die to hear you miss me  
Do I have to die to hear you say goodbye  
I don’t want to act like there’s tomorrow  
I don’t want to wait to do this one more time  
One more time, one more, one more time, one more time_

https://www.youtube.com/watch?v=fSKQRDq3RkM
