import sys
from passlib.context import CryptContext

# Create a single global instance for your app
pwd_context = CryptContext(
    # Replace this list with the hash(es) you wish to support.
    # This example sets pbkdf2_sha256 as the default,
    # with additional support for reading legacy des_crypt hashes.
    schemes=["pbkdf2_sha256", "des_crypt"],

    # Automatically mark all but first hasher in list as deprecated.
    # (this will be the default in Passlib 2.0)
    deprecated="auto",

    # Optionally, set the number of rounds that should be used.
    # Appropriate values may vary for different schemes,
    # and the amount of time you wish it to take.
    # Leaving this alone is usually safe, and will use passlib's defaults.
    pbkdf2_sha256__rounds=29000,
)

def main():

    if len(sys.argv) < 2:
        print("Usage: python hash_script.py <string_to_hash>")
        sys.exit(1)

    # Get the string to hash from the command line arguments
    password_candidate = sys.argv[1]
    stored_hash = sys.argv[2]


    # Set up argument parser
    # parser = argparse.ArgumentParser(description="Check if a given string hashes to a given hash.")
    # parser.add_argument("password_candidate", help="The password we want to see if it matches with the stored Hash")
    # parser.add_argument("stored_hash", help="The stored Hash for the given user")

    # Parse the arguments
    # args = parser.parse_args()

    print(password_candidate)
    print(stored_hash)
    # Print wether or not the hashes match
    print(pwd_context.verify(password_candidate, stored_hash))

 
if __name__ == "__main__":
    main()
