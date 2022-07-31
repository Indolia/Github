//
//  PullRequestModel.swift
//  Github
//
//  Created by Rishi Indolia on 30/07/22.
//

import Foundation


protocol PullRequestModelProtocal: Decodable {
    var id: Int { get }
    var state: String {get}
    var title: String {get}
    var url: String { get }
    var head: PRHeadModel { get }
    var createdAt: String { get }
    var closedAt: String? { get }
    var body: String? {get}
    var user: UserInfoModel {get}
}

struct PullRequestModel: PullRequestModelProtocal {
    
    let id: Int
    let state: String
    var title: String
    let url: String
    let head: PRHeadModel
    let createdAt: String
    let closedAt: String?
    let body: String?
    let user: UserInfoModel
    
    var searchable: String {
        return user.login + " " + (body ?? "") + " " + title
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PullRequestModelCodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        state = try container.decode(String.self, forKey: .state)
        title = try container.decode(String.self, forKey: .title)
        url = try container.decode(String.self, forKey: .url)
        head = try container.decode(PRHeadModel.self, forKey: .head)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        closedAt = try? container.decode(String.self, forKey: .closedAt)
        body = try? container.decode(String.self, forKey: .body)
        user = try container.decode(UserInfoModel.self, forKey: .user)
    }
}

enum PullRequestModelCodingKeys: String, CodingKey {
    case id = "id"
    case state = "state"
    case title = "title"
    case url = "url"
    case head = "head"
    case createdAt = "created_at"
    case closedAt  = "closed_at"
    case body = "body"
    case user = "user"
}

protocol PRHeadModelProtocol: Decodable {
    var label: String {get}
    var user: UserInfoModel {get}
}

struct PRHeadModel: PRHeadModelProtocol {
    let label: String
    let user: UserInfoModel
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PRHeadModelCodingKeys.self)
        label = try container.decode(String.self, forKey: .label)
        user = try container.decode(UserInfoModel.self, forKey: .user)
    }
}

enum PRHeadModelCodingKeys: String, CodingKey {
    case label = "label"
    case user = "user"
}

//"closed_at" = "2022-07-30T16:22:44Z";
//"comments_url" = "https://api.github.com/repos/Indolia/Github/issues/7/comments";
//"commits_url" = "https://api.github.com/repos/Indolia/Github/pulls/7/commits";
//"created_at" = "2022-07-30T16:22:22Z";
//"diff_url" = "https://github.com/Indolia/Github/pull/7.diff";
//
//    "active_lock_reason" = "<null>";
//    assignee =     {
//        "avatar_url" = "https://avatars.githubusercontent.com/u/13569479?v=4";
//        "events_url" = "https://api.github.com/users/Indolia/events{/privacy}";
//        "followers_url" = "https://api.github.com/users/Indolia/followers";
//        "following_url" = "https://api.github.com/users/Indolia/following{/other_user}";
//        "gists_url" = "https://api.github.com/users/Indolia/gists{/gist_id}";
//        "gravatar_id" = "";
//        "html_url" = "https://github.com/Indolia";
//        id = 13569479;
//        login = Indolia;
//        "node_id" = MDQ6VXNlcjEzNTY5NDc5;
//        "organizations_url" = "https://api.github.com/users/Indolia/orgs";
//        "received_events_url" = "https://api.github.com/users/Indolia/received_events";
//        "repos_url" = "https://api.github.com/users/Indolia/repos";
//        "site_admin" = 0;
//        "starred_url" = "https://api.github.com/users/Indolia/starred{/owner}{/repo}";
//        "subscriptions_url" = "https://api.github.com/users/Indolia/subscriptions";
//        type = User;
//        url = "https://api.github.com/users/Indolia";
//    };
//    assignees =     (
//                {
//            "avatar_url" = "https://avatars.githubusercontent.com/u/13569479?v=4";
//            "events_url" = "https://api.github.com/users/Indolia/events{/privacy}";
//            "followers_url" = "https://api.github.com/users/Indolia/followers";
//            "following_url" = "https://api.github.com/users/Indolia/following{/other_user}";
//            "gists_url" = "https://api.github.com/users/Indolia/gists{/gist_id}";
//            "gravatar_id" = "";
//            "html_url" = "https://github.com/Indolia";
//            id = 13569479;
//            login = Indolia;
//            "node_id" = MDQ6VXNlcjEzNTY5NDc5;
//            "organizations_url" = "https://api.github.com/users/Indolia/orgs";
//            "received_events_url" = "https://api.github.com/users/Indolia/received_events";
//            "repos_url" = "https://api.github.com/users/Indolia/repos";
//            "site_admin" = 0;
//            "starred_url" = "https://api.github.com/users/Indolia/starred{/owner}{/repo}";
//            "subscriptions_url" = "https://api.github.com/users/Indolia/subscriptions";
//            type = User;
//            url = "https://api.github.com/users/Indolia";
//        }
//    );
//    "author_association" = OWNER;
//    "auto_merge" = "<null>";
//    base =     {
//        label = "Indolia:main";
//        ref = main;
//        repo =         {
//            "allow_forking" = 1;
//            "archive_url" = "https://api.github.com/repos/Indolia/Github/{archive_format}{/ref}";
//            archived = 0;
//            "assignees_url" = "https://api.github.com/repos/Indolia/Github/assignees{/user}";
//            "blobs_url" = "https://api.github.com/repos/Indolia/Github/git/blobs{/sha}";
//            "branches_url" = "https://api.github.com/repos/Indolia/Github/branches{/branch}";
//            "clone_url" = "https://github.com/Indolia/Github.git";
//            "collaborators_url" = "https://api.github.com/repos/Indolia/Github/collaborators{/collaborator}";
//            "comments_url" = "https://api.github.com/repos/Indolia/Github/comments{/number}";
//            "commits_url" = "https://api.github.com/repos/Indolia/Github/commits{/sha}";
//            "compare_url" = "https://api.github.com/repos/Indolia/Github/compare/{base}...{head}";
//            "contents_url" = "https://api.github.com/repos/Indolia/Github/contents/{+path}";
//            "contributors_url" = "https://api.github.com/repos/Indolia/Github/contributors";
//            "created_at" = "2022-07-30T08:59:38Z";
//            "default_branch" = main;
//            "deployments_url" = "https://api.github.com/repos/Indolia/Github/deployments";
//            description = "Demo for Github API";
//            disabled = 0;
//            "downloads_url" = "https://api.github.com/repos/Indolia/Github/downloads";
//            "events_url" = "https://api.github.com/repos/Indolia/Github/events";
//            fork = 0;
//            forks = 0;
//            "forks_count" = 0;
//            "forks_url" = "https://api.github.com/repos/Indolia/Github/forks";
//            "full_name" = "Indolia/Github";
//            "git_commits_url" = "https://api.github.com/repos/Indolia/Github/git/commits{/sha}";
//            "git_refs_url" = "https://api.github.com/repos/Indolia/Github/git/refs{/sha}";
//            "git_tags_url" = "https://api.github.com/repos/Indolia/Github/git/tags{/sha}";
//            "git_url" = "git://github.com/Indolia/Github.git";
//            "has_downloads" = 1;
//            "has_issues" = 1;
//            "has_pages" = 0;
//            "has_projects" = 1;
//            "has_wiki" = 1;
//            homepage = "<null>";
//            "hooks_url" = "https://api.github.com/repos/Indolia/Github/hooks";
//            "html_url" = "https://github.com/Indolia/Github";
//            id = 519467397;
//            "is_template" = 0;
//            "issue_comment_url" = "https://api.github.com/repos/Indolia/Github/issues/comments{/number}";
//            "issue_events_url" = "https://api.github.com/repos/Indolia/Github/issues/events{/number}";
//            "issues_url" = "https://api.github.com/repos/Indolia/Github/issues{/number}";
//            "keys_url" = "https://api.github.com/repos/Indolia/Github/keys{/key_id}";
//            "labels_url" = "https://api.github.com/repos/Indolia/Github/labels{/name}";
//            language = Swift;
//            "languages_url" = "https://api.github.com/repos/Indolia/Github/languages";
//            license = "<null>";
//            "merges_url" = "https://api.github.com/repos/Indolia/Github/merges";
//            "milestones_url" = "https://api.github.com/repos/Indolia/Github/milestones{/number}";
//            "mirror_url" = "<null>";
//            name = Github;
//            "node_id" = "R_kgDOHvZxhQ";
//            "notifications_url" = "https://api.github.com/repos/Indolia/Github/notifications{?since,all,participating}";
//            "open_issues" = 0;
//            "open_issues_count" = 0;
//            owner =             {
//                "avatar_url" = "https://avatars.githubusercontent.com/u/13569479?v=4";
//                "events_url" = "https://api.github.com/users/Indolia/events{/privacy}";
//                "followers_url" = "https://api.github.com/users/Indolia/followers";
//                "following_url" = "https://api.github.com/users/Indolia/following{/other_user}";
//                "gists_url" = "https://api.github.com/users/Indolia/gists{/gist_id}";
//                "gravatar_id" = "";
//                "html_url" = "https://github.com/Indolia";
//                id = 13569479;
//                login = Indolia;
//                "node_id" = MDQ6VXNlcjEzNTY5NDc5;
//                "organizations_url" = "https://api.github.com/users/Indolia/orgs";
//                "received_events_url" = "https://api.github.com/users/Indolia/received_events";
//                "repos_url" = "https://api.github.com/users/Indolia/repos";
//                "site_admin" = 0;
//                "starred_url" = "https://api.github.com/users/Indolia/starred{/owner}{/repo}";
//                "subscriptions_url" = "https://api.github.com/users/Indolia/subscriptions";
//                type = User;
//                url = "https://api.github.com/users/Indolia";
//            };
//            private = 0;
//            "pulls_url" = "https://api.github.com/repos/Indolia/Github/pulls{/number}";
//            "pushed_at" = "2022-07-30T16:22:44Z";
//            "releases_url" = "https://api.github.com/repos/Indolia/Github/releases{/id}";
//            size = 594;
//            "ssh_url" = "git@github.com:Indolia/Github.git";
//            "stargazers_count" = 0;
//            "stargazers_url" = "https://api.github.com/repos/Indolia/Github/stargazers";
//            "statuses_url" = "https://api.github.com/repos/Indolia/Github/statuses/{sha}";
//            "subscribers_url" = "https://api.github.com/repos/Indolia/Github/subscribers";
//            "subscription_url" = "https://api.github.com/repos/Indolia/Github/subscription";
//            "svn_url" = "https://github.com/Indolia/Github";
//            "tags_url" = "https://api.github.com/repos/Indolia/Github/tags";
//            "teams_url" = "https://api.github.com/repos/Indolia/Github/teams";
//            topics =             (
//            );
//            "trees_url" = "https://api.github.com/repos/Indolia/Github/git/trees{/sha}";
//            "updated_at" = "2022-07-30T09:34:31Z";
//            url = "https://api.github.com/repos/Indolia/Github";
//            visibility = public;
//            watchers = 0;
//            "watchers_count" = 0;
//            "web_commit_signoff_required" = 0;
//        };
//        sha = de602ab74c93365a0fec4f3bdcd3bb93e89979ec;
//        user =         {
//            "avatar_url" = "https://avatars.githubusercontent.com/u/13569479?v=4";
//            "events_url" = "https://api.github.com/users/Indolia/events{/privacy}";
//            "followers_url" = "https://api.github.com/users/Indolia/followers";
//            "following_url" = "https://api.github.com/users/Indolia/following{/other_user}";
//            "gists_url" = "https://api.github.com/users/Indolia/gists{/gist_id}";
//            "gravatar_id" = "";
//            "html_url" = "https://github.com/Indolia";
//            id = 13569479;
//            login = Indolia;
//            "node_id" = MDQ6VXNlcjEzNTY5NDc5;
//            "organizations_url" = "https://api.github.com/users/Indolia/orgs";
//            "received_events_url" = "https://api.github.com/users/Indolia/received_events";
//            "repos_url" = "https://api.github.com/users/Indolia/repos";
//            "site_admin" = 0;
//            "starred_url" = "https://api.github.com/users/Indolia/starred{/owner}{/repo}";
//            "subscriptions_url" = "https://api.github.com/users/Indolia/subscriptions";
//            type = User;
//            url = "https://api.github.com/users/Indolia";
//        };
//    };
//    body = "create keychain handler to store user git-hub account details for auto-login";
//    "closed_at" = "2022-07-30T16:22:44Z";
//    "comments_url" = "https://api.github.com/repos/Indolia/Github/issues/7/comments";
//    "commits_url" = "https://api.github.com/repos/Indolia/Github/pulls/7/commits";
//    "created_at" = "2022-07-30T16:22:22Z";
//    "diff_url" = "https://github.com/Indolia/Github/pull/7.diff";
//    draft = 0;
//    head =     {
//        label = "Indolia:task/create-login-node-and-ui";
//        ref = "task/create-login-node-and-ui";
//        repo =         {
//            "allow_forking" = 1;
//            "archive_url" = "https://api.github.com/repos/Indolia/Github/{archive_format}{/ref}";
//            archived = 0;
//            "assignees_url" = "https://api.github.com/repos/Indolia/Github/assignees{/user}";
//            "blobs_url" = "https://api.github.com/repos/Indolia/Github/git/blobs{/sha}";
//            "branches_url" = "https://api.github.com/repos/Indolia/Github/branches{/branch}";
//            "clone_url" = "https://github.com/Indolia/Github.git";
//            "collaborators_url" = "https://api.github.com/repos/Indolia/Github/collaborators{/collaborator}";
//            "comments_url" = "https://api.github.com/repos/Indolia/Github/comments{/number}";
//            "commits_url" = "https://api.github.com/repos/Indolia/Github/commits{/sha}";
//            "compare_url" = "https://api.github.com/repos/Indolia/Github/compare/{base}...{head}";
//            "contents_url" = "https://api.github.com/repos/Indolia/Github/contents/{+path}";
//            "contributors_url" = "https://api.github.com/repos/Indolia/Github/contributors";
//            "created_at" = "2022-07-30T08:59:38Z";
//            "default_branch" = main;
//            "deployments_url" = "https://api.github.com/repos/Indolia/Github/deployments";
//            description = "Demo for Github API";
//            disabled = 0;
//            "downloads_url" = "https://api.github.com/repos/Indolia/Github/downloads";
//            "events_url" = "https://api.github.com/repos/Indolia/Github/events";
//            fork = 0;
//            forks = 0;
//            "forks_count" = 0;
//            "forks_url" = "https://api.github.com/repos/Indolia/Github/forks";
//            "full_name" = "Indolia/Github";
//            "git_commits_url" = "https://api.github.com/repos/Indolia/Github/git/commits{/sha}";
//            "git_refs_url" = "https://api.github.com/repos/Indolia/Github/git/refs{/sha}";
//            "git_tags_url" = "https://api.github.com/repos/Indolia/Github/git/tags{/sha}";
//            "git_url" = "git://github.com/Indolia/Github.git";
//            "has_downloads" = 1;
//            "has_issues" = 1;
//            "has_pages" = 0;
//            "has_projects" = 1;
//            "has_wiki" = 1;
//            homepage = "<null>";
//            "hooks_url" = "https://api.github.com/repos/Indolia/Github/hooks";
//            "html_url" = "https://github.com/Indolia/Github";
//            id = 519467397;
//            "is_template" = 0;
//            "issue_comment_url" = "https://api.github.com/repos/Indolia/Github/issues/comments{/number}";
//            "issue_events_url" = "https://api.github.com/repos/Indolia/Github/issues/events{/number}";
//            "issues_url" = "https://api.github.com/repos/Indolia/Github/issues{/number}";
//            "keys_url" = "https://api.github.com/repos/Indolia/Github/keys{/key_id}";
//            "labels_url" = "https://api.github.com/repos/Indolia/Github/labels{/name}";
//            language = Swift;
//            "languages_url" = "https://api.github.com/repos/Indolia/Github/languages";
//            license = "<null>";
//            "merges_url" = "https://api.github.com/repos/Indolia/Github/merges";
//            "milestones_url" = "https://api.github.com/repos/Indolia/Github/milestones{/number}";
//            "mirror_url" = "<null>";
//            name = Github;
//            "node_id" = "R_kgDOHvZxhQ";
//            "notifications_url" = "https://api.github.com/repos/Indolia/Github/notifications{?since,all,participating}";
//            "open_issues" = 0;
//            "open_issues_count" = 0;
//            owner =             {
//                "avatar_url" = "https://avatars.githubusercontent.com/u/13569479?v=4";
//                "events_url" = "https://api.github.com/users/Indolia/events{/privacy}";
//                "followers_url" = "https://api.github.com/users/Indolia/followers";
//                "following_url" = "https://api.github.com/users/Indolia/following{/other_user}";
//                "gists_url" = "https://api.github.com/users/Indolia/gists{/gist_id}";
//                "gravatar_id" = "";
//                "html_url" = "https://github.com/Indolia";
//                id = 13569479;
//                login = Indolia;
//                "node_id" = MDQ6VXNlcjEzNTY5NDc5;
//                "organizations_url" = "https://api.github.com/users/Indolia/orgs";
//                "received_events_url" = "https://api.github.com/users/Indolia/received_events";
//                "repos_url" = "https://api.github.com/users/Indolia/repos";
//                "site_admin" = 0;
//                "starred_url" = "https://api.github.com/users/Indolia/starred{/owner}{/repo}";
//                "subscriptions_url" = "https://api.github.com/users/Indolia/subscriptions";
//                type = User;
//                url = "https://api.github.com/users/Indolia";
//            };
//            private = 0;
//            "pulls_url" = "https://api.github.com/repos/Indolia/Github/pulls{/number}";
//            "pushed_at" = "2022-07-30T16:22:44Z";
//            "releases_url" = "https://api.github.com/repos/Indolia/Github/releases{/id}";
//            size = 594;
//            "ssh_url" = "git@github.com:Indolia/Github.git";
//            "stargazers_count" = 0;
//            "stargazers_url" = "https://api.github.com/repos/Indolia/Github/stargazers";
//            "statuses_url" = "https://api.github.com/repos/Indolia/Github/statuses/{sha}";
//            "subscribers_url" = "https://api.github.com/repos/Indolia/Github/subscribers";
//            "subscription_url" = "https://api.github.com/repos/Indolia/Github/subscription";
//            "svn_url" = "https://github.com/Indolia/Github";
//            "tags_url" = "https://api.github.com/repos/Indolia/Github/tags";
//            "teams_url" = "https://api.github.com/repos/Indolia/Github/teams";
//            topics =             (
//            );
//            "trees_url" = "https://api.github.com/repos/Indolia/Github/git/trees{/sha}";
//            "updated_at" = "2022-07-30T09:34:31Z";
//            url = "https://api.github.com/repos/Indolia/Github";
//            visibility = public;
//            watchers = 0;
//            "watchers_count" = 0;
//            "web_commit_signoff_required" = 0;
//        };
//        sha = 76126175dac31a2cc67656bdb28cb25fce9579dc;
//        user =         {
//            "avatar_url" = "https://avatars.githubusercontent.com/u/13569479?v=4";
//            "events_url" = "https://api.github.com/users/Indolia/events{/privacy}";
//            "followers_url" = "https://api.github.com/users/Indolia/followers";
//            "following_url" = "https://api.github.com/users/Indolia/following{/other_user}";
//            "gists_url" = "https://api.github.com/users/Indolia/gists{/gist_id}";
//            "gravatar_id" = "";
//            "html_url" = "https://github.com/Indolia";
//            id = 13569479;
//            login = Indolia;
//            "node_id" = MDQ6VXNlcjEzNTY5NDc5;
//            "organizations_url" = "https://api.github.com/users/Indolia/orgs";
//            "received_events_url" = "https://api.github.com/users/Indolia/received_events";
//            "repos_url" = "https://api.github.com/users/Indolia/repos";
//            "site_admin" = 0;
//            "starred_url" = "https://api.github.com/users/Indolia/starred{/owner}{/repo}";
//            "subscriptions_url" = "https://api.github.com/users/Indolia/subscriptions";
//            type = User;
//            url = "https://api.github.com/users/Indolia";
//        };
//    };
//    "html_url" = "https://github.com/Indolia/Github/pull/7";
//    id = 1012814988;
//    "issue_url" = "https://api.github.com/repos/Indolia/Github/issues/7";
//    labels =     (
//    );
//    locked = 0;
//    "merge_commit_sha" = f29af5d8fff7d6dcca7beda7a79ba3062a694fea;
//    "merged_at" = "2022-07-30T16:22:44Z";
//    milestone = "<null>";
//    "node_id" = "PR_kwDOHvZxhc48XlSM";
//    number = 7;
//    "patch_url" = "https://github.com/Indolia/Github/pull/7.patch";
//    "requested_reviewers" =     (
//    );
//    "requested_teams" =     (
//    );
//    "review_comment_url" = "https://api.github.com/repos/Indolia/Github/pulls/comments{/number}";
//    "review_comments_url" = "https://api.github.com/repos/Indolia/Github/pulls/7/comments";
//    state = closed;
//    "statuses_url" = "https://api.github.com/repos/Indolia/Github/statuses/76126175dac31a2cc67656bdb28cb25fce9579dc";
//    title = "create the login node and ui";
//    "updated_at" = "2022-07-30T16:22:44Z";
//    url = "https://api.github.com/repos/Indolia/Github/pulls/7";
//    user =     {
//        "avatar_url" = "https://avatars.githubusercontent.com/u/13569479?v=4";
//        "events_url" = "https://api.github.com/users/Indolia/events{/privacy}";
//        "followers_url" = "https://api.github.com/users/Indolia/followers";
//        "following_url" = "https://api.github.com/users/Indolia/following{/other_user}";
//        "gists_url" = "https://api.github.com/users/Indolia/gists{/gist_id}";
//        "gravatar_id" = "";
//        "html_url" = "https://github.com/Indolia";
//        id = 13569479;
//        login = Indolia;
//        "node_id" = MDQ6VXNlcjEzNTY5NDc5;
//        "organizations_url" = "https://api.github.com/users/Indolia/orgs";
//        "received_events_url" = "https://api.github.com/users/Indolia/received_events";
//        "repos_url" = "https://api.github.com/users/Indolia/repos";
//        "site_admin" = 0;
//        "starred_url" = "https://api.github.com/users/Indolia/starred{/owner}{/repo}";
//        "subscriptions_url" = "https://api.github.com/users/Indolia/subscriptions";
//        type = User;
//        url = "https://api.github.com/users/Indolia";
//    };
//}
