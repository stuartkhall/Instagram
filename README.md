A simple block based Objective-C wrapper around the Instagram API

Requires AFNetworking

simple example:

// Fetch a user by ID
[client getUser:@"128643"
        success:^(InstagramUser* user) {
            NSLog(@"\r\n\r\nGot user : %@ (%@)\r\n\r\n", user.fullname, user.username);
        } 
        failure:^(NSError *error, NSInteger statusCode) {
            NSLog(@"Error fetching user %ld - %@", statusCode, [error localizedDescription]);
        }
 ];