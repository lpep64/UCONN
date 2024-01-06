import { callExternalApi } from "./external-api.service";

const apiServerUrl = import.meta.env.VITE_API_SERVER_URL;

export const getPublicResource = async () => {
  console.log("getPublicResource()");
  const config = {
    url: `${apiServerUrl}/api/messages/public`,
    method: "GET",
    headers: {
      "content-type": "application/json",
    },
  };

  const { data, error } = await callExternalApi({ config });

  return {
    data: data || null,
    error,
  };
};

//export const getProtectedResource = async () => {
export const getProtectedResource = async (accessToken) => {  //STEP2

  console.log("getProtectedResource()");
  const config = {
    //url: `${apiServerUrl}/api/messages/protected`,
    url: `${apiServerUrl}/test`, //STEP2
    method: "GET",
    headers: {
      "content-type": "application/json",
      Authorization: `Bearer ${accessToken}`,  //STEP2
    },
  };

  const { data, error } = await callExternalApi({ config });

  return {
    data: data || null,
    error,
  };
};

export const getAdminResource = async () => {
  console.log("getAdminResource()");
  const config = {
    url: `${apiServerUrl}/api/messages/admin`,
    method: "GET",
    headers: {
      "content-type": "application/json",
    },
  };

  const { data, error } = await callExternalApi({ config });

  return {
    data: data || null,
    error,
  };
};
