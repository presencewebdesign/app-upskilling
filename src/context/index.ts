import { useContext } from "react";
import { SjrProvider, SjrContext, type SjrContextValue } from "./SjrContext";

export const useSjrContext = () => useContext(SjrContext);

export type { SjrContextValue };

export { SjrProvider };
