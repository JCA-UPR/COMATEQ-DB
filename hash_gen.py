import argparse
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
    # Set up argument parser
    parser = argparse.ArgumentParser(description="Hash a string using passlib")
    parser.add_argument("string_to_hash", help="The string to hash")

    # Parse the arguments
    args = parser.parse_args()

    # Hash the input string using the configured context
    hash = pwd_context.hash(args.string_to_hash)

    # Print the hash
    print(hash)
 
if __name__ == "__main__":
    main()
