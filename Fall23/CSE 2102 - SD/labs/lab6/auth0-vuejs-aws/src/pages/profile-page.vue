<template>
  <PageLayout>
    <div class="content-layout">
      <h1 id="page-title" class="content__title">Profile Page</h1>
      <div class="content__body">
        <p id="page-description">
          <span
            ><strong
              >Only authenticated users should access this page.</strong
            ></span
          >
        </p>
        <div class="profile-grid">
          <div class="profile__header">
            <img :src="user.picture" alt="Profile" class="profile__avatar" />
            <div class="profile__headline">
              <h2 class="profile__title">{{ user.name }}</h2>
              <span class="profile__description">{{ user.email }}</span>
            </div>
          </div>
          <div class="profile__details">
            <CodeSnippet title="User Profile Object" :code="code" />
          </div>
        </div>
      </div>
    </div>
  </PageLayout>
</template>

<script setup>
import CodeSnippet from "@/components/code-snippet.vue";
import PageLayout from "@/components/page-layout.vue";
import { useAuth0 } from "@auth0/auth0-vue";

console.log("profile-page.vue");

const { user } = useAuth0();

const code = user ? JSON.stringify(user.value, null, 2) : "";

// const user = {
//   nickname: "Customer",
//   name: "One Customer",
//   picture: "https://cdn.auth0.com/blog/hello-auth0/auth0-user.png",
//   updated_at: "2021-05-04T21:33:09.415Z",
//   email: "customer@example.com",
//   email_verified: false,
//   sub: "auth0|12345678901234567890",
// };

// const code = JSON.stringify(user, null, 2);


</script>
